defmodule Unicorn.ServerController do
  use Unicorn.Web, :controller

  alias Unicorn.{
    ServerSerializer
  }

  alias Unicorn.Server.{
    CreateAction,
    ShowAction
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

  def show(conn, params) do
    case ShowAction.run(%{name: params["name"]}) do
        {:ok, result} ->
          conn
          |> put_status(:ok)
          |> render("show.json-api", data: result.model)

        {:error, :find_unicorn, result} ->
          conn
          |> put_status(:not_found)
          |> render(:errors, data: %{
              id: 1,
              status: 404,
              code: "not-found",
              title: "Server not found",
              detail: "Server #{params["name"]} is not available on this server" 
            })
    end
  end
end
