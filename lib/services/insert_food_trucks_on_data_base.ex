defmodule Services.InsertFoodTrucksOnDataBase do
  alias ExFoodTruck.FoodTrucksFoodItems.FoodTruckFoodItem
  alias ExFoodTruck.FoodItems
  alias ExFoodTruck.FoodTrucks
  alias ExFoodTruck.FoodItems.FoodItem
  alias ExFoodTruck.Repo
  alias Providers.SfData

  def execute() do
    with {:ok, food_trucks} <- SfData.get_food_trucks(),
         food_items <- reduce_food_items(food_trucks),
         {:ok, _food_items} <- insert_food_items(food_items),
         {:ok, inserted_food_trucks} <- insert_food_trucks(food_trucks) do
      {:ok, inserted_food_trucks}
    end
  end

  defp insert_food_trucks(food_trucks) do
    Enum.reduce(food_trucks, {:ok, []}, fn food_truck, {:ok, acc} ->
      food_items = Map.get(food_truck, :food_items, [])

      with {:ok, food_truck} <- FoodTrucks.create_food_truck(food_truck),
           food_items <- FoodItems.list_food_items_by_name(food_items),
           {:ok, _food_truck_food_items} <-
             insert_food_truck_food_items(food_truck.id, food_items) do
        {:ok, [food_truck.id | acc]}
      else
        _error ->
          {:ok, acc}
      end
    end)
  end

  defp reduce_food_items(food_trucks) do
    food_trucks
    |> Enum.reduce([], fn food_truck, acc ->
      food_items = Map.get(food_truck, :food_items, [])

      acc ++ food_items
    end)
    |> MapSet.new()
    |> MapSet.reject(&(is_nil(&1) or &1 == ""))
  end

  defp insert_food_items(food_items) do
    food_items
    |> Enum.map(&FoodItem.changeset(%FoodItem{}, %{name: &1}))
    |> Enum.reduce_while({:ok, []}, fn changeset, {:ok, acc} ->
      case Repo.insert(changeset) do
        {:ok, insertion} -> {:cont, {:ok, [insertion | acc]}}
        {:error, changeset} -> {:halt, {:error, changeset}}
      end
    end)
  end

  defp insert_food_truck_food_items(food_truck_id, food_items) do
    food_items
    |> Enum.map(
      &FoodTruckFoodItem.changeset(%FoodTruckFoodItem{}, %{
        food_truck_id: food_truck_id,
        food_item_id: &1.id
      })
    )
    |> Enum.reduce_while({:ok, []}, fn changeset, {:ok, acc} ->
      case Repo.insert(changeset) do
        {:ok, insertion} -> {:cont, {:ok, [insertion | acc]}}
        {:error, changeset} -> {:halt, {:error, changeset}}
      end
    end)
  end
end
