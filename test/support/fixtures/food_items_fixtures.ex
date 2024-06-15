defmodule ExFoodTruck.FoodItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ExFoodTruck.FoodItems` context.
  """

  @doc """
  Generate a food_item.
  """
  def food_item_fixture(attrs \\ %{}) do
    {:ok, food_item} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> ExFoodTruck.FoodItems.create_food_item()

    food_item
  end
end
