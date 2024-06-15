defmodule ExFoodTruckWeb.RecommendationController do
  use ExFoodTruckWeb, :controller
  alias ExFoodTruck.Recommendation

  def index(conn, %{"food_items" => food_items}) do
    case Recommendation.recommend(food_items) do
      [] ->
        conn
        |> put_status(:not_found)
        |> json(%{message: "There's no food trucks that offers the given food items"})

      recommendations ->
        conn
        |> put_status(:ok)
        |> json(recommendations)
    end
  end
end
