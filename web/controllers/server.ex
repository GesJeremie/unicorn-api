defmodule Unicorn.ServerController do
  use Unicorn.Web, :controller

  alias Unicorn.{
    ServerSerializer
  }

  alias Unicorn.Server.{
    CreateAction
  }

  def create(conn, _params) do

    case CreateAction.run() do
      {:ok, result} ->
        conn
        |> put_status(:created)
        |> render("show.json-api", data: result.model)

      {:error, :save, result} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: result.contract)
    end

  end
end
