defmodule Providers.SfData.Response do
  def parse({:ok, food_trucks}) do
    food_trucks =
      Enum.map(food_trucks, fn food_truck ->
        %{
          name: Map.get(food_truck, :applicant),
          status: Map.get(food_truck, :status),
          location: Map.get(food_truck, :locationdescription),
          facility_type: Map.get(food_truck, :facilitytype),
          food_items: parse_food_items(Map.get(food_truck, :fooditems))
        }
      end)

    {:ok, food_trucks}
  end

  defp parse_food_items(nil), do: []

  defp parse_food_items(food_items) do
    food_items
    |> String.split(":")
    |> Enum.map(fn food_item ->
      food_item
      |> String.trim()
      |> String.downcase()
    end)
  end
end
