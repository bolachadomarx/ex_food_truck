defmodule ExFoodTruck.RecommendationTest do
  use ExFoodTruck.DataCase, async: true

  import ExFoodTruck.FoodTrucksFoodItemsFixtures
  import ExFoodTruck.FoodTrucksFixtures
  import ExFoodTruck.FoodItemsFixtures

  alias ExFoodTruck.Recommendation

  describe "recommend/1" do
    test "should return recommendation based on food_items names" do
      food_items = ["salads"]

      food_item = food_item_fixture(%{name: "salads"})
      food_truck = food_truck_fixture()

      food_truck_food_item_fixture(%{
        food_truck_id: food_truck.id,
        food_item_id: food_item.id
      })

      assert [%{food_truck: ^food_truck, food_items: ^food_items}] =
               Recommendation.recommend(food_items)
    end

    test "should return empty list when there is no recommendation based on the food_items names" do
      food_items = ["eggs"]

      food_item = food_item_fixture(%{name: "salads"})
      food_truck = food_truck_fixture()

      food_truck_food_item_fixture(%{
        food_truck_id: food_truck.id,
        food_item_id: food_item.id
      })

      assert [] =
               Recommendation.recommend(food_items)
    end
  end
end
