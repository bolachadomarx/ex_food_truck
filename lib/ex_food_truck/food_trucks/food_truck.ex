defmodule ExFoodTruck.FoodTrucks.FoodTruck do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExFoodTruck.FoodTrucksFoodItems.FoodTruckFoodItem

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @derive {Jason.Encoder, only: [:id, :name, :status, :location, :facility_type]}

  schema "food_trucks" do
    field :name, :string
    field :status, :string
    field :location, :string, default: "San Francisco"
    field :facility_type, :string, default: "Truck"

    has_many :food_truck_food_items, FoodTruckFoodItem, foreign_key: :food_truck_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(food_truck, attrs) do
    food_truck
    |> cast(attrs, [:name, :facility_type, :location, :status])
    |> validate_required([:name, :location, :status])
    |> unique_constraint([:name, :location])
  end
end
