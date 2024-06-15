defmodule Providers.SfData.Client do
  use Tesla

  alias Providers.SfData.Response

  @base_url "https://data.sfgov.org/resource/rqzj-sfat.json"

  def get_food_trucks do
    client()
    |> get("")
    |> match_response()
    |> Response.parse()
  end

  defp client do
    tesla_middlewares = [
      {Tesla.Middleware.BaseUrl, @base_url},
      {Tesla.Middleware.Logger, log_level: :info},
      {Tesla.Middleware.JSON, engine_opts: [keys: :atoms]}
    ]

    Tesla.client(tesla_middlewares)
  end

  defp match_response({:ok, %{status: status, body: body}}) do
    case status do
      status when status in 200..299 and is_list(body) ->
        {:ok, body}

      status ->
        {:error, %{status: status, body: body}}
    end
  end
end
