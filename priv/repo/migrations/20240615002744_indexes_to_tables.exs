defmodule ExFoodTruck.Repo.Migrations.IndexesToTables do
  use Ecto.Migration

  def change do
    create unique_index("food_trucks", [:name, :location])
    create unique_index("food_items", [:name])
  end
end
