defmodule ExFoodTruck.Repo.Migrations.CreateFoodTrucksFoodItems do
  use Ecto.Migration

  def change do
    create table(:food_trucks_food_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :food_item_id, references(:food_items, column: :id, type: :binary_id)
      add :food_truck_id, references(:food_trucks, column: :id, type: :binary_id)

      timestamps(type: :utc_datetime)
    end
  end
end
