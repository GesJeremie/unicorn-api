defmodule Unicorn.UserController do
  use Unicorn.Web, :controller

  alias Unicorn.{
    UserSerializer
  }

  alias Unicorn.User.{
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
    case ShowAction.run(%{id: params["id"]}) do
        {:ok, result} ->
          conn
          |> put_status(:ok)
          |> render("show.json-api", data: result.model)

        {:error, :validate, result} ->
          conn
          |> put_status(:not_found)
          |> render(:errors, data: %{
              status: 404,
              code: "resource-not-found",
              detail: "User #{params["id"]} is not available on this server" 
            })
    end
  end
end
