defmodule ExFoodTruck.FoodItemsTest do
  use ExFoodTruck.DataCase

  alias ExFoodTruck.FoodItems

  describe "food_items" do
    alias ExFoodTruck.FoodItems.FoodItem

    import ExFoodTruck.FoodItemsFixtures

    @invalid_attrs %{name: nil}

    test "list_food_items/0 returns all food_items" do
      food_item = food_item_fixture()
      assert FoodItems.list_food_items() == [food_item]
    end

    test "get_food_item!/1 returns the food_item with given id" do
      food_item = food_item_fixture()
      assert FoodItems.get_food_item!(food_item.id) == food_item
    end

    test "create_food_item/1 with valid data creates a food_item" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %FoodItem{} = food_item} = FoodItems.create_food_item(valid_attrs)
      assert food_item.name == "some name"
    end

    test "create_food_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodItems.create_food_item(@invalid_attrs)
    end

    test "update_food_item/2 with valid data updates the food_item" do
      food_item = food_item_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %FoodItem{} = food_item} = FoodItems.update_food_item(food_item, update_attrs)
      assert food_item.name == "some updated name"
    end

    test "update_food_item/2 with invalid data returns error changeset" do
      food_item = food_item_fixture()
      assert {:error, %Ecto.Changeset{}} = FoodItems.update_food_item(food_item, @invalid_attrs)
      assert food_item == FoodItems.get_food_item!(food_item.id)
    end

    test "delete_food_item/1 deletes the food_item" do
      food_item = food_item_fixture()
      assert {:ok, %FoodItem{}} = FoodItems.delete_food_item(food_item)
      assert_raise Ecto.NoResultsError, fn -> FoodItems.get_food_item!(food_item.id) end
    end

    test "change_food_item/1 returns a food_item changeset" do
      food_item = food_item_fixture()
      assert %Ecto.Changeset{} = FoodItems.change_food_item(food_item)
    end

    test "list_food_items_by_name/1 should return all food item that matches with the given names" do
      %{id: id} = food_item_fixture()

      assert [%{id: ^id}] = FoodItems.list_food_items_by_name(["some", "name"])
    end
  end
end
