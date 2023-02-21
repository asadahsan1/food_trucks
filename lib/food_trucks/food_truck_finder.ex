defmodule FoodTrucks.FoodTruckFinder do
  @moduledoc """
  The FoodTruckFinder context.
  """

  import Ecto.Query, warn: false
  alias FoodTrucks.Repo

  alias FoodTrucks.FoodTruckFinder.FoodTrucksFinders

  @doc """
  Returns the list of food_trucks_finder.

  ## Examples

      iex> list_food_trucks_finder()
      [%FoodTrucksFinders{}, ...]

  """
  def list_food_trucks_finder do
    Repo.all(FoodTrucksFinders)
  end

  @doc """
  Gets a single food_trucks_finders.

  Raises `Ecto.NoResultsError` if the Food trucks finders does not exist.

  ## Examples

      iex> get_food_trucks_finders!(123)
      %FoodTrucksFinders{}

      iex> get_food_trucks_finders!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_trucks_finders!(id), do: Repo.get!(FoodTrucksFinders, id)

  @doc """
  Creates a food_trucks_finders.

  ## Examples

      iex> create_food_trucks_finders(%{field: value})
      {:ok, %FoodTrucksFinders{}}

      iex> create_food_trucks_finders(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_trucks_finders(attrs \\ %{}) do
    %FoodTrucksFinders{}
    |> FoodTrucksFinders.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_trucks_finders.

  ## Examples

      iex> update_food_trucks_finders(food_trucks_finders, %{field: new_value})
      {:ok, %FoodTrucksFinders{}}

      iex> update_food_trucks_finders(food_trucks_finders, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_trucks_finders(%FoodTrucksFinders{} = food_trucks_finders, attrs) do
    food_trucks_finders
    |> FoodTrucksFinders.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a food_trucks_finders.

  ## Examples

      iex> delete_food_trucks_finders(food_trucks_finders)
      {:ok, %FoodTrucksFinders{}}

      iex> delete_food_trucks_finders(food_trucks_finders)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_trucks_finders(%FoodTrucksFinders{} = food_trucks_finders) do
    Repo.delete(food_trucks_finders)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_trucks_finders changes.

  ## Examples

      iex> change_food_trucks_finders(food_trucks_finders)
      %Ecto.Changeset{data: %FoodTrucksFinders{}}

  """
  def change_food_trucks_finders(%FoodTrucksFinders{} = food_trucks_finders, attrs \\ %{}) do
    FoodTrucksFinders.changeset(food_trucks_finders, attrs)
  end
end
