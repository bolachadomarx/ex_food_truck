defmodule ExFoodTruck.FoodTrucksFoodItemsTest do
  use ExFoodTruck.DataCase

  alias ExFoodTruck.FoodTrucksFoodItems

  describe "food_trucks_food_items" do
    alias ExFoodTruck.FoodTrucksFoodItems.FoodTruckFoodItem

    import ExFoodTruck.FoodTrucksFoodItemsFixtures
    import ExFoodTruck.FoodTrucksFixtures
    import ExFoodTruck.FoodItemsFixtures

    @invalid_attrs %{food_item_id: nil, food_truck_id: nil}

    test "list_food_trucks_food_items/0 returns all food_trucks_food_items" do
      food_item = food_item_fixture()
      food_truck = food_truck_fixture()

      food_truck_food_item =
        food_truck_food_item_fixture(%{
          food_truck_id: food_truck.id,
          food_item_id: food_item.id
        })

      assert FoodTrucksFoodItems.list_food_trucks_food_items() == [food_truck_food_item]
    end

    test "get_food_truck_food_item!/1 returns the food_truck_food_item with given id" do
      food_item = food_item_fixture()
      food_truck = food_truck_fixture()

      food_truck_food_item =
        food_truck_food_item_fixture(%{
          food_truck_id: food_truck.id,
          food_item_id: food_item.id
        })

      assert FoodTrucksFoodItems.get_food_truck_food_item!(food_truck_food_item.id) ==
               food_truck_food_item
    end

    test "create_food_truck_food_item/1 with valid data creates a food_truck_food_item" do
      food_item = food_item_fixture()
      food_truck = food_truck_fixture()

      valid_attrs = %{
        food_item_id: food_item.id,
        food_truck_id: food_truck.id
      }

      assert {:ok, %FoodTruckFoodItem{}} =
               FoodTrucksFoodItems.create_food_truck_food_item(valid_attrs)
    end

    test "create_food_truck_food_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               FoodTrucksFoodItems.create_food_truck_food_item(@invalid_attrs)
    end

    test "update_food_truck_food_item/2 with valid data updates the food_truck_food_item" do
      food_item = food_item_fixture()
      food_truck = food_truck_fixture()

      food_truck_food_item =
        food_truck_food_item_fixture(%{
          food_truck_id: food_truck.id,
          food_item_id: food_item.id
        })

      new_food_item = food_item_fixture(%{name: "another food"})
      new_food_truck = food_truck_fixture(%{name: "another food truck"})

      update_attrs = %{
        food_item_id: new_food_item.id,
        food_truck_id: new_food_truck.id
      }

      assert {:ok, %FoodTruckFoodItem{}} =
               FoodTrucksFoodItems.update_food_truck_food_item(food_truck_food_item, update_attrs)
    end

    test "update_food_truck_food_item/2 with invalid data returns error changeset" do
      food_item = food_item_fixture()
      food_truck = food_truck_fixture()

      food_truck_food_item =
        food_truck_food_item_fixture(%{
          food_truck_id: food_truck.id,
          food_item_id: food_item.id
        })

      assert {:error, %Ecto.Changeset{}} =
               FoodTrucksFoodItems.update_food_truck_food_item(
                 food_truck_food_item,
                 @invalid_attrs
               )

      assert food_truck_food_item ==
               FoodTrucksFoodItems.get_food_truck_food_item!(food_truck_food_item.id)
    end

    test "delete_food_truck_food_item/1 deletes the food_truck_food_item" do
      food_item = food_item_fixture()
      food_truck = food_truck_fixture()

      food_truck_food_item =
        food_truck_food_item_fixture(%{
          food_truck_id: food_truck.id,
          food_item_id: food_item.id
        })

      assert {:ok, %FoodTruckFoodItem{}} =
               FoodTrucksFoodItems.delete_food_truck_food_item(food_truck_food_item)

      assert_raise Ecto.NoResultsError, fn ->
        FoodTrucksFoodItems.get_food_truck_food_item!(food_truck_food_item.id)
      end
    end

    test "change_food_truck_food_item/1 returns a food_truck_food_item changeset" do
      food_item = food_item_fixture()
      food_truck = food_truck_fixture()

      food_truck_food_item =
        food_truck_food_item_fixture(%{
          food_truck_id: food_truck.id,
          food_item_id: food_item.id
        })

      assert %Ecto.Changeset{} =
               FoodTrucksFoodItems.change_food_truck_food_item(food_truck_food_item)
    end

    test "list_by_food_items_ids/1 returns all food_trucks_food_items by food_item_ids" do
      food_item = food_item_fixture()
      food_truck = food_truck_fixture()

      %{id: id} =
        food_truck_food_item_fixture(%{
          food_truck_id: food_truck.id,
          food_item_id: food_item.id
        })

      assert [%{id: ^id}] =
               FoodTrucksFoodItems.list_by_food_items_ids([food_item.id])
    end
  end
end
