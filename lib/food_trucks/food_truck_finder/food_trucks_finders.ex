defmodule FoodTrucks.FoodTruckFinder.FoodTrucksFinders do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_trucks_finder" do
    field :address, :string
    field :latitude, :string
    field :longitude, :string
    field :truck_name, :string

    timestamps()
  end

  @doc false
  def changeset(food_trucks_finders, attrs) do
    food_trucks_finders
    |> cast(attrs, [:truck_name, :address, :latitude, :longitude])
    |> validate_required([:truck_name, :address, :latitude, :longitude])
  end
end
