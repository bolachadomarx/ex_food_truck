defmodule ExFoodTruck.FoodTrucksFoodItems.FoodTruckFoodItem do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExFoodTruck.FoodTrucks.FoodTruck
  alias ExFoodTruck.FoodItems.FoodItem

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "food_trucks_food_items" do
    belongs_to :food_item, FoodItem
    belongs_to :food_truck, FoodTruck

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(food_truck_food_item, attrs) do
    food_truck_food_item
    |> cast(attrs, [:food_item_id, :food_truck_id])
    |> validate_required([:food_item_id, :food_truck_id])
  end
end
