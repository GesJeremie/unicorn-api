defmodule Unicorn.ServerController do
  use Unicorn.Web, :controller

  alias Unicorn.Server.{
    CreateServerAction
  }

  def create(conn, params) do

    result = CreateServerAction.run(params)

    # Return some static JSON for now
    conn
    |> json(%{status: "Ok"})
  end
end
