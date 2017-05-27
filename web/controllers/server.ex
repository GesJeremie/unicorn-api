defmodule Unicorn.ServerController do
  use Unicorn.Web, :controller

  alias Unicorn.Server.{
    CreateAction
  }

  def create(conn, params) do

    #result = CreateServerAction.run(params)

    # Return some static JSON for now
    conn
    |> json(%{status: "Ok"})
  end
end
