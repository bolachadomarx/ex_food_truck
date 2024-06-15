defmodule Providers.SfData do
  alias Providers.SfData.Client

  def get_food_trucks() do
    Client.get_food_trucks()
  end
end
