defmodule ExFoodTruck.FoodItems do
  @moduledoc """
  The FoodItems context.
  """

  import Ecto.Query, warn: false
  alias ExFoodTruck.Repo

  alias ExFoodTruck.FoodItems.FoodItem

  @doc """
  Returns the list of food_items.

  ## Examples

      iex> list_food_items()
      [%FoodItem{}, ...]

  """
  def list_food_items do
    Repo.all(FoodItem)
  end

  @doc """
  Gets a single food_item.

  Raises `Ecto.NoResultsError` if the Food item does not exist.

  ## Examples

      iex> get_food_item!(123)
      %FoodItem{}

      iex> get_food_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_item!(id), do: Repo.get!(FoodItem, id)

  @doc """
  Creates a food_item.

  ## Examples

      iex> create_food_item(%{field: value})
      {:ok, %FoodItem{}}

      iex> create_food_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_item(attrs \\ %{}) do
    %FoodItem{}
    |> FoodItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_item.

  ## Examples

      iex> update_food_item(food_item, %{field: new_value})
      {:ok, %FoodItem{}}

      iex> update_food_item(food_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_item(%FoodItem{} = food_item, attrs) do
    food_item
    |> FoodItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a food_item.

  ## Examples

      iex> delete_food_item(food_item)
      {:ok, %FoodItem{}}

      iex> delete_food_item(food_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_item(%FoodItem{} = food_item) do
    Repo.delete(food_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_item changes.

  ## Examples

      iex> change_food_item(food_item)
      %Ecto.Changeset{data: %FoodItem{}}

  """
  def change_food_item(%FoodItem{} = food_item, attrs \\ %{}) do
    FoodItem.changeset(food_item, attrs)
  end

  @doc """
  Returns a list of FoodItems filtered by the food_item name.

  ## Examples

      iex> list_food_items_by_name(food_items)
      [%FoodItem{}, %FoodItem{}, %FoodItem{}]

  """
  def list_food_items_by_name(food_items) do
    food_items_to_search = Enum.map(food_items, &"%#{&1}%")

    query = from(fi in FoodItem)

    query =
      Enum.reduce(food_items_to_search, query, fn pattern, query ->
        from fi in query,
          or_where: like(fi.name, ^pattern)
      end)

    Repo.all(query)
  end
end
