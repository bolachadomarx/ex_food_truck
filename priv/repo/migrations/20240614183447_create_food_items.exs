defmodule ExFoodTruck.Repo.Migrations.CreateFoodItems do
  use Ecto.Migration

  def change do
    create table(:food_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
