defmodule ExFoodTruck.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExFoodTruckWeb.Telemetry,
      ExFoodTruck.Repo,
      {DNSCluster, query: Application.get_env(:ex_food_truck, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ExFoodTruck.PubSub},
      # Start a worker by calling: ExFoodTruck.Worker.start_link(arg)
      # {ExFoodTruck.Worker, arg},
      # Start to serve requests, typically the last entry
      ExFoodTruckWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExFoodTruck.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExFoodTruckWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
