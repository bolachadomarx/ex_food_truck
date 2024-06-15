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
      handle_recommendations(recommendations)
    end
  end

  defp food_items_ids(food_items), do: Enum.map(food_items, & &1.id)

  defp handle_recommendations(recommendations) do
    recommendations
    |> Enum.group_by(& &1.food_truck)
    |> Enum.map(fn {food_truck, food_truck_food_items} ->
      food_items = handle_food_items(food_truck_food_items)

      %{food_truck: food_truck, food_items: food_items}
    end)
  end

  defp handle_food_items(food_truck_food_items) do
    Enum.map(food_truck_food_items, & &1.food_item.name)
  end
end
