defmodule ExFoodTruckWeb.RecommendationControllerTest do
  use ExFoodTruckWeb.ConnCase, async: true

  import ExFoodTruck.FoodTrucksFoodItemsFixtures
  import ExFoodTruck.FoodTrucksFixtures
  import ExFoodTruck.FoodItemsFixtures

  describe "index/2" do
    test "should return all food trucks that offers the given food items", %{conn: conn} do
      food_item_name = "egg"

      food_item = food_item_fixture(%{name: food_item_name})
      %{id: food_truck_id} = food_truck_fixture()

      food_truck_food_item_fixture(%{
        food_truck_id: food_truck_id,
        food_item_id: food_item.id
      })

      conn = get(conn, ~p"/api/recommendation?food_items[]=#{food_item_name}")

      assert [
               %{
                 "food_item" => "egg",
                 "food_truck" => %{
                   "facility_type" => "some facility_type",
                   "id" => ^food_truck_id,
                   "location" => "some location",
                   "name" => "some name",
                   "status" => "some status"
                 }
               }
             ] = json_response(conn, 200)
    end

    test "should return 404 and message if there is no foodtrucks to be recommended", %{
      conn: conn
    } do
      food_item_name = "egg"

      food_item = food_item_fixture()
      %{id: food_truck_id} = food_truck_fixture()

      food_truck_food_item_fixture(%{
        food_truck_id: food_truck_id,
        food_item_id: food_item.id
      })

      conn = get(conn, ~p"/api/recommendation?food_items[]=#{food_item_name}")

      assert %{"message" => "There's no food trucks that offers the given food items"} =
               json_response(conn, 404)
    end

    test "should return 400 and message if food items array is not in params", %{conn: conn} do
      conn = get(conn, ~p"/api/recommendation")

      assert %{"message" => "food_items is required on the query params"} =
               json_response(conn, 400)
    end
  end
end
