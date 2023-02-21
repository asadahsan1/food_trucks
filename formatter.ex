defmodule StoreServices.Headcount.Stores.Formatter do
  @moduledoc """
  Responsible for transforming incoming CSV lines into appropriately formatted output.
  """
  @line_headers [
    :invc_sid,
    :store_no,
    :b,
    :c,
    :date,
    :d,
    :qty,
    :orig_price,
    :orig_tax_amt,
    :e,
    :f
  ]

  @spec format_line(list()) :: map()
  def format_line(row) do
    %{
      invc_sid: invc_sid,
      store_no: store_no,
      date: date,
      qty: qty,
      orig_price: orig_price,
      orig_tax_amt: orig_tax_amt
    } =
      row
      |> Stream.zip_with(@line_headers, &{&2, &1})
      |> Enum.into(%{})

    date = NaiveDateTime.from_iso8601!(date)

    %{
      invc_sid: invc_sid,
      store_name: "CycleGear#{String.pad_leading(store_no, 3, "0")}",
      created_date: Calendar.strftime(date, "%m/%d/%Y"),
      hours: date.hour,
      orig_price: String.to_float(orig_price),
      orig_tax_amt: String.to_float(orig_tax_amt),
      qty: String.to_float(qty)
    }
  end

  @spec consolidate_orders(list()) :: list()
  def consolidate_orders(orders) do
    orders
    |> Enum.group_by(fn %{store_name: store_name} -> store_name end)
    |> Enum.map(fn {_, x} -> Enum.group_by(x, fn %{created_date: date} -> date end) end)
    |> Enum.map(fn store ->
      Enum.map(
        store,
        fn {_date, purchases} ->
          consolidate_totals(purchases)
        end
      )
    end)
  end

  defp consolidate_totals(orders) do
    orders
    |> Enum.sort_by(fn %{hours: hour} -> hour end)
    |> Enum.chunk_by(fn %{hours: hour} -> hour end)
    |> List.first()
    |> case do
      [hd] ->
        Map.merge(hd, %{
          qty: hd.qty,
          transactions: 1,
          total_amt: hd.orig_price * hd.qty + hd.orig_tax_amt * hd.qty
        })
        |> Map.drop([:orig_price, :orig_tax_amt])

      [hd | _] = chunked ->
        Map.merge(hd, %{
          qty: Enum.reduce(chunked, 0, fn chunk, acc -> chunk.qty + acc end),
          transactions: sum_transactions(chunked),
          total_amt: sum_totals(chunked)
        })
        |> Map.drop([:orig_price, :orig_tax_amt])

      _ ->
        nil
    end
  end

  @spec format_output(map()) :: list()
  def format_output(%{
        store_name: name,
        created_date: date,
        hours: hour,
        transactions: transactions,
        qty: qty,
        total_amt: total_amt
      }) do
    [name, date, hour, transactions, qty, total_amt, 0]
  end

  defp sum_transactions(chunked) do
    Enum.group_by(chunked, fn %{invc_sid: invc_sid} -> invc_sid end)
    |> Map.keys()
    |> Enum.count()
  end

  defp sum_totals(chunked) do
    Enum.chunk_by(chunked, fn %{invc_sid: invc_sid} -> invc_sid end)
    |> Enum.reduce(0, fn trans, acc ->
      trans_sum =
        Enum.map(
          trans,
          &(&1.orig_price * &1.qty + &1.orig_tax_amt * &1.qty)
        )
        |> Enum.sum()

      trans_sum + acc
    end)
  end
end
