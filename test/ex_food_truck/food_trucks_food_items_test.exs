defmodule ExFoodTruck.FoodTrucksFoodItemsTest do
  use ExFoodTruck.DataCase

  alias ExFoodTruck.FoodTrucksFoodItems

  describe "food_trucks_food_items" do
    alias ExFoodTruck.FoodTrucksFoodItems.FoodTruckFoodItem

    import ExFoodTruck.FoodTrucksFoodItemsFixtures

    @invalid_attrs %{food_item_id: nil, food_truck_id: nil}

    test "list_food_trucks_food_items/0 returns all food_trucks_food_items" do
      food_truck_food_item = food_truck_food_item_fixture()
      assert FoodTrucksFoodItems.list_food_trucks_food_items() == [food_truck_food_item]
    end

    test "get_food_truck_food_item!/1 returns the food_truck_food_item with given id" do
      food_truck_food_item = food_truck_food_item_fixture()

      assert FoodTrucksFoodItems.get_food_truck_food_item!(food_truck_food_item.id) ==
               food_truck_food_item
    end

    test "create_food_truck_food_item/1 with valid data creates a food_truck_food_item" do
      valid_attrs = %{
        food_item_id: "7488a646-e31f-11e4-aace-600308960662",
        food_truck_id: "7488a646-e31f-11e4-aace-600308960662"
      }

      assert {:ok, %FoodTruckFoodItem{} = food_truck_food_item} =
               FoodTrucksFoodItems.create_food_truck_food_item(valid_attrs)

      assert food_truck_food_item.food_item_id == "7488a646-e31f-11e4-aace-600308960662"
      assert food_truck_food_item.food_truck_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_food_truck_food_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               FoodTrucksFoodItems.create_food_truck_food_item(@invalid_attrs)
    end

    test "update_food_truck_food_item/2 with valid data updates the food_truck_food_item" do
      food_truck_food_item = food_truck_food_item_fixture()

      update_attrs = %{
        food_item_id: "7488a646-e31f-11e4-aace-600308960668",
        food_truck_id: "7488a646-e31f-11e4-aace-600308960668"
      }

      assert {:ok, %FoodTruckFoodItem{} = food_truck_food_item} =
               FoodTrucksFoodItems.update_food_truck_food_item(food_truck_food_item, update_attrs)

      assert food_truck_food_item.food_item_id == "7488a646-e31f-11e4-aace-600308960668"
      assert food_truck_food_item.food_truck_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_food_truck_food_item/2 with invalid data returns error changeset" do
      food_truck_food_item = food_truck_food_item_fixture()

      assert {:error, %Ecto.Changeset{}} =
               FoodTrucksFoodItems.update_food_truck_food_item(
                 food_truck_food_item,
                 @invalid_attrs
               )

      assert food_truck_food_item ==
               FoodTrucksFoodItems.get_food_truck_food_item!(food_truck_food_item.id)
    end

    test "delete_food_truck_food_item/1 deletes the food_truck_food_item" do
      food_truck_food_item = food_truck_food_item_fixture()

      assert {:ok, %FoodTruckFoodItem{}} =
               FoodTrucksFoodItems.delete_food_truck_food_item(food_truck_food_item)

      assert_raise Ecto.NoResultsError, fn ->
        FoodTrucksFoodItems.get_food_truck_food_item!(food_truck_food_item.id)
      end
    end

    test "change_food_truck_food_item/1 returns a food_truck_food_item changeset" do
      food_truck_food_item = food_truck_food_item_fixture()

      assert %Ecto.Changeset{} =
               FoodTrucksFoodItems.change_food_truck_food_item(food_truck_food_item)
    end
  end
end
