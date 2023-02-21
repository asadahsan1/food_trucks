defmodule FoodTrucks.FoodTruckFinderTest do
  use FoodTrucks.DataCase

  alias FoodTrucks.FoodTruckFinder

  describe "food_trucks_finder" do
    alias FoodTrucks.FoodTruckFinder.FoodTrucksFinders

    import FoodTrucks.FoodTruckFinderFixtures

    @invalid_attrs %{address: nil, latitude: nil, longitude: nil, truck_name: nil}

    test "list_food_trucks_finder/0 returns all food_trucks_finder" do
      food_trucks_finders = food_trucks_finders_fixture()
      assert FoodTruckFinder.list_food_trucks_finder() == [food_trucks_finders]
    end

    test "get_food_trucks_finders!/1 returns the food_trucks_finders with given id" do
      food_trucks_finders = food_trucks_finders_fixture()
      assert FoodTruckFinder.get_food_trucks_finders!(food_trucks_finders.id) == food_trucks_finders
    end

    test "create_food_trucks_finders/1 with valid data creates a food_trucks_finders" do
      valid_attrs = %{address: "some address", latitude: "some latitude", longitude: "some longitude", truck_name: "some truck_name"}

      assert {:ok, %FoodTrucksFinders{} = food_trucks_finders} = FoodTruckFinder.create_food_trucks_finders(valid_attrs)
      assert food_trucks_finders.address == "some address"
      assert food_trucks_finders.latitude == "some latitude"
      assert food_trucks_finders.longitude == "some longitude"
      assert food_trucks_finders.truck_name == "some truck_name"
    end

    test "create_food_trucks_finders/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodTruckFinder.create_food_trucks_finders(@invalid_attrs)
    end

    test "update_food_trucks_finders/2 with valid data updates the food_trucks_finders" do
      food_trucks_finders = food_trucks_finders_fixture()
      update_attrs = %{address: "some updated address", latitude: "some updated latitude", longitude: "some updated longitude", truck_name: "some updated truck_name"}

      assert {:ok, %FoodTrucksFinders{} = food_trucks_finders} = FoodTruckFinder.update_food_trucks_finders(food_trucks_finders, update_attrs)
      assert food_trucks_finders.address == "some updated address"
      assert food_trucks_finders.latitude == "some updated latitude"
      assert food_trucks_finders.longitude == "some updated longitude"
      assert food_trucks_finders.truck_name == "some updated truck_name"
    end

    test "update_food_trucks_finders/2 with invalid data returns error changeset" do
      food_trucks_finders = food_trucks_finders_fixture()
      assert {:error, %Ecto.Changeset{}} = FoodTruckFinder.update_food_trucks_finders(food_trucks_finders, @invalid_attrs)
      assert food_trucks_finders == FoodTruckFinder.get_food_trucks_finders!(food_trucks_finders.id)
    end

    test "delete_food_trucks_finders/1 deletes the food_trucks_finders" do
      food_trucks_finders = food_trucks_finders_fixture()
      assert {:ok, %FoodTrucksFinders{}} = FoodTruckFinder.delete_food_trucks_finders(food_trucks_finders)
      assert_raise Ecto.NoResultsError, fn -> FoodTruckFinder.get_food_trucks_finders!(food_trucks_finders.id) end
    end

    test "change_food_trucks_finders/1 returns a food_trucks_finders changeset" do
      food_trucks_finders = food_trucks_finders_fixture()
      assert %Ecto.Changeset{} = FoodTruckFinder.change_food_trucks_finders(food_trucks_finders)
    end
  end
end
