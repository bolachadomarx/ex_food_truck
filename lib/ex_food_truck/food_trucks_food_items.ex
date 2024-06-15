defmodule ExFoodTruck.FoodTrucksFoodItems do
  @moduledoc """
  The FoodTrucksFoodItems context.
  """

  import Ecto.Query, warn: false
  alias ExFoodTruck.Repo

  alias ExFoodTruck.FoodTrucksFoodItems.FoodTruckFoodItem

  @doc """
  Returns the list of food_trucks_food_items.

  ## Examples

      iex> list_food_trucks_food_items()
      [%FoodTruckFoodItem{}, ...]

  """
  def list_food_trucks_food_items do
    Repo.all(FoodTruckFoodItem)
  end

  @doc """
  Gets a single food_truck_food_item.

  Raises `Ecto.NoResultsError` if the Food truck food item does not exist.

  ## Examples

      iex> get_food_truck_food_item!(123)
      %FoodTruckFoodItem{}

      iex> get_food_truck_food_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_truck_food_item!(id), do: Repo.get!(FoodTruckFoodItem, id)

  @doc """
  Creates a food_truck_food_item.

  ## Examples

      iex> create_food_truck_food_item(%{field: value})
      {:ok, %FoodTruckFoodItem{}}

      iex> create_food_truck_food_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_truck_food_item(attrs \\ %{}) do
    %FoodTruckFoodItem{}
    |> FoodTruckFoodItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_truck_food_item.

  ## Examples

      iex> update_food_truck_food_item(food_truck_food_item, %{field: new_value})
      {:ok, %FoodTruckFoodItem{}}

      iex> update_food_truck_food_item(food_truck_food_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_truck_food_item(%FoodTruckFoodItem{} = food_truck_food_item, attrs) do
    food_truck_food_item
    |> FoodTruckFoodItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a food_truck_food_item.

  ## Examples

      iex> delete_food_truck_food_item(food_truck_food_item)
      {:ok, %FoodTruckFoodItem{}}

      iex> delete_food_truck_food_item(food_truck_food_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_truck_food_item(%FoodTruckFoodItem{} = food_truck_food_item) do
    Repo.delete(food_truck_food_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_truck_food_item changes.

  ## Examples

      iex> change_food_truck_food_item(food_truck_food_item)
      %Ecto.Changeset{data: %FoodTruckFoodItem{}}

  """
  def change_food_truck_food_item(%FoodTruckFoodItem{} = food_truck_food_item, attrs \\ %{}) do
    FoodTruckFoodItem.changeset(food_truck_food_item, attrs)
  end

  @doc """
  Returns a list of food_truck_food_item with preloaded food_item and food_truck using food_item_ids.

  ## Examples

      iex> list_by_food_items_ids(food_items_ids)
      [%FoodTruckFoodItem{}, %FoodTruckFoodItem{}, %FoodTruckFoodItem{}]

  """
  def list_by_food_items_ids(food_items_ids) do
    FoodTruckFoodItem
    |> from()
    |> where([ftfi], ftfi.food_item_id in ^food_items_ids)
    |> preload(:food_truck)
    |> preload(:food_item)
    |> Repo.all()
  end
end
