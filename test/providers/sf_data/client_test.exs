defmodule Providers.SfData.ClientTest do
  use ExFoodTruck.DataCase, async: true
  import Tesla.Mock

  alias Providers.SfData.Client

  describe "get_food_trucks/0" do
    setup do
      mock(fn
        %{method: :get, url: "https://data.sfgov.org/resource/rqzj-sfat.json"} ->
          %Tesla.Env{
            status: 200,
            body: [
              %{
                applicant: "random food truck",
                status: "APPROVED",
                locationdescription: "San Francisco",
                facilitytype: "Food Truck",
                fooditems: "eggs:salads:fruits"
              }
            ]
          }
      end)

      :ok
    end

    test "returns a list of food trucks when the response is successful" do
      assert {:ok,
              [
                %{
                  name: "random food truck",
                  facility_type: "Food Truck",
                  food_items: ["eggs", "salads", "fruits"],
                  location: "San Francisco",
                  status: "APPROVED"
                }
              ]} = Client.get_food_trucks()
    end

    test "returns an error when the response is unsuccessful" do
      mock(fn
        %{method: :get, url: "https://data.sfgov.org/resource/rqzj-sfat.json"} ->
          %Tesla.Env{status: 500, body: "Internal Server Error"}
      end)

      assert {:error, %{status: 500, body: "Internal Server Error"}} = Client.get_food_trucks()
    end
  end
end
