defmodule ExFoodTruck.FoodTrucksFoodItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ExFoodTruck.FoodTrucksFoodItems` context.
  """

  @doc """
  Generate a food_truck_food_item.
  """
  def food_truck_food_item_fixture(attrs \\ %{}) do
    {:ok, food_truck_food_item} =
      attrs
      |> Enum.into(%{
        food_item_id: "7488a646-e31f-11e4-aace-600308960662",
        food_truck_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> ExFoodTruck.FoodTrucksFoodItems.create_food_truck_food_item()

    food_truck_food_item
  end
end
