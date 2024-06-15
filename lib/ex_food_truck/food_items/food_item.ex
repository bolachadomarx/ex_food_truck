defmodule ExFoodTruck.FoodItems.FoodItem do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExFoodTruck.FoodTrucksFoodItems.FoodTruckFoodItem

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "food_items" do
    field :name, :string

    has_many :food_truck_food_items, FoodTruckFoodItem, foreign_key: :food_truck_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(food_item, attrs) do
    food_item
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
