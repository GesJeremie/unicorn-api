defmodule Unicorn.SongController do
  use Unicorn.Web, :controller

  alias Unicorn.{}

  alias Unicorn.Youtube.{
    SearchAction,
  }

  def index(conn, %{"query" => query}) do

    case SearchAction.run(%{query: query}) do
      {:ok, result} ->
        conn
        |> put_status(:ok)
        |> render("index.json-api", data: result.songs)
      {:error, _, result} ->
        conn
        |> put_status(:not_found)
        |> render(:errors, data: %{
            id: 1,
            status: 404,
            code: "not-found",
            title: "Songs not found",
            detail: "Can't retrieve results"
          })
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
