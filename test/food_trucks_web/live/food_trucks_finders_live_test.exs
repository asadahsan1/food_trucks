defmodule FoodTrucksWeb.FoodTrucksFindersLiveTest do
  use FoodTrucksWeb.ConnCase

  import Phoenix.LiveViewTest
  import FoodTrucks.FoodTruckFinderFixtures

  @create_attrs %{address: "some address", latitude: "some latitude", longitude: "some longitude", truck_name: "some truck_name"}
  @update_attrs %{address: "some updated address", latitude: "some updated latitude", longitude: "some updated longitude", truck_name: "some updated truck_name"}
  @invalid_attrs %{address: nil, latitude: nil, longitude: nil, truck_name: nil}

  defp create_food_trucks_finders(_) do
    food_trucks_finders = food_trucks_finders_fixture()
    %{food_trucks_finders: food_trucks_finders}
  end

  describe "Index" do
    setup [:create_food_trucks_finders]

    test "lists all food_trucks_finder", %{conn: conn, food_trucks_finders: food_trucks_finders} do
      {:ok, _index_live, html} = live(conn, Routes.food_trucks_finders_index_path(conn, :index))

      assert html =~ "Listing Food trucks finder"
      assert html =~ food_trucks_finders.address
    end

    test "saves new food_trucks_finders", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.food_trucks_finders_index_path(conn, :index))

      assert index_live |> element("a", "New Food trucks finders") |> render_click() =~
               "New Food trucks finders"

      assert_patch(index_live, Routes.food_trucks_finders_index_path(conn, :new))

      assert index_live
             |> form("#food_trucks_finders-form", food_trucks_finders: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#food_trucks_finders-form", food_trucks_finders: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.food_trucks_finders_index_path(conn, :index))

      assert html =~ "Food trucks finders created successfully"
      assert html =~ "some address"
    end

    test "updates food_trucks_finders in listing", %{conn: conn, food_trucks_finders: food_trucks_finders} do
      {:ok, index_live, _html} = live(conn, Routes.food_trucks_finders_index_path(conn, :index))

      assert index_live |> element("#food_trucks_finders-#{food_trucks_finders.id} a", "Edit") |> render_click() =~
               "Edit Food trucks finders"

      assert_patch(index_live, Routes.food_trucks_finders_index_path(conn, :edit, food_trucks_finders))

      assert index_live
             |> form("#food_trucks_finders-form", food_trucks_finders: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#food_trucks_finders-form", food_trucks_finders: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.food_trucks_finders_index_path(conn, :index))

      assert html =~ "Food trucks finders updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes food_trucks_finders in listing", %{conn: conn, food_trucks_finders: food_trucks_finders} do
      {:ok, index_live, _html} = live(conn, Routes.food_trucks_finders_index_path(conn, :index))

      assert index_live |> element("#food_trucks_finders-#{food_trucks_finders.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#food_trucks_finders-#{food_trucks_finders.id}")
    end
  end

  describe "Show" do
    setup [:create_food_trucks_finders]

    test "displays food_trucks_finders", %{conn: conn, food_trucks_finders: food_trucks_finders} do
      {:ok, _show_live, html} = live(conn, Routes.food_trucks_finders_show_path(conn, :show, food_trucks_finders))

      assert html =~ "Show Food trucks finders"
      assert html =~ food_trucks_finders.address
    end

    test "updates food_trucks_finders within modal", %{conn: conn, food_trucks_finders: food_trucks_finders} do
      {:ok, show_live, _html} = live(conn, Routes.food_trucks_finders_show_path(conn, :show, food_trucks_finders))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Food trucks finders"

      assert_patch(show_live, Routes.food_trucks_finders_show_path(conn, :edit, food_trucks_finders))

      assert show_live
             |> form("#food_trucks_finders-form", food_trucks_finders: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#food_trucks_finders-form", food_trucks_finders: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.food_trucks_finders_show_path(conn, :show, food_trucks_finders))

      assert html =~ "Food trucks finders updated successfully"
      assert html =~ "some updated address"
    end
  end
end
