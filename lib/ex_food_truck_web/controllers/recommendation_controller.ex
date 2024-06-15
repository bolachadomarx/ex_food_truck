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

  def index(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: "food_items is required on the query params"})
  end
end
