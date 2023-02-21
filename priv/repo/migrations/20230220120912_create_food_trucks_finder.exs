defmodule FoodTrucks.Repo.Migrations.CreateFoodTrucksFinder do
  use Ecto.Migration

  def change do
    create table(:food_trucks_finder) do
      add :truck_name, :string
      add :address, :string
      add :latitude, :string
      add :longitude, :string

      timestamps()
    end
  end
end
