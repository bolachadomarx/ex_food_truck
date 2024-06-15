defmodule ExFoodTruck.Repo.Migrations.CreateFoodTrucks do
  use Ecto.Migration

  def change do
    create table(:food_trucks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :facility_type, :string
      add :location, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
