defmodule ExFoodTruck.FoodTrucksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ExFoodTruck.FoodTrucks` context.
  """

  @doc """
  Generate a food_truck.
  """
  def food_truck_fixture(attrs \\ %{}) do
    {:ok, food_truck} =
      attrs
      |> Enum.into(%{
        facility_type: "some facility_type",
        location: "some location",
        name: "some name",
        status: "some status"
      })
      |> ExFoodTruck.FoodTrucks.create_food_truck()

    food_truck
  end
end
