defmodule ExFoodTruck.Recommendation do
  alias ExFoodTruck.FoodTrucks.FoodTruck
  alias ExFoodTruck.FoodTrucksFoodItems
  alias ExFoodTruck.FoodItems

  @doc """
  Returns a list of food_truck based on a list of food_items.
  """
  @spec recommend(food_items :: list(binary())) ::
          list(%{food_truck: %FoodTruck{}, food_item: binary()})
  def recommend(food_items) do
    with food_items <- FoodItems.list_food_items_by_name(food_items),
         recommendations <-
           FoodTrucksFoodItems.list_by_food_items_ids(food_items_ids(food_items)) do
      Enum.map(recommendations, &%{food_truck: &1.food_truck, food_item: &1.food_item.name})
    end
  end

  defp food_items_ids(food_items), do: Enum.map(food_items, & &1.id)
end
