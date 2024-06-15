defmodule Services.InsertFoodTrucksOnDataBaseTest do
  use ExFoodTruck.DataCase, async: true
  use Mimic

  alias Services.InsertFoodTrucksOnDataBase
  alias Providers.SfData

  setup :verify_on_exit!

  describe "execute/0" do
    test "should return :ok and the inserted food_truck ids if execution succeds" do
      expect(SfData, :get_food_trucks, fn ->
        {:ok,
         [
           %{
             name: "deli foods",
             facility_type: "Food Truck",
             food_items: ["eggs", "salads", "fruits"],
             location: "San Francisco",
             status: "APPROVED"
           },
           %{
             name: "cali foods",
             facility_type: "Food Truck",
             food_items: ["eggs", "salads", "fruits"],
             location: "San Francisco",
             status: "APPROVED"
           }
         ]}
      end)

      assert {:ok, [_, _]} =
               InsertFoodTrucksOnDataBase.execute()
    end

    test "should return :ok and empty list if insert food trucks at execution" do
      expect(SfData, :get_food_trucks, fn ->
        {:ok,
         [
           %{
             name: 3,
             facility_type: "Food Truck",
             food_items: ["eggs", "salads", "fruits"],
             location: "San Francisco",
             status: "APPROVED"
           },
           %{
             name: 1,
             facility_type: "Food Truck",
             food_items: ["eggs", "salads", "fruits"],
             location: "San Francisco",
             status: "APPROVED"
           }
         ]}
      end)

      assert {:ok, []} =
               InsertFoodTrucksOnDataBase.execute()
    end
  end
end
