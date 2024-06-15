defmodule ExFoodTruck.Repo do
  use Ecto.Repo,
    otp_app: :ex_food_truck,
    adapter: Ecto.Adapters.Postgres
end
