defmodule FoodTrucks.FoodTruckFinderFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodTrucks.FoodTruckFinder` context.
  """

  @doc """
  Generate a food_trucks_finders.
  """
  def food_trucks_finders_fixture(attrs \\ %{}) do
    {:ok, food_trucks_finders} =
      attrs
      |> Enum.into(%{
        address: "some address",
        latitude: "some latitude",
        longitude: "some longitude",
        truck_name: "some truck_name"
      })
      |> FoodTrucks.FoodTruckFinder.create_food_trucks_finders()

    food_trucks_finders
  end
end
