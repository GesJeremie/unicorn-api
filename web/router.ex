defmodule Unicorn.Router do
  use Unicorn.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/", Unicorn do
    pipe_through :api

    get "/servers/create", ServerController, :create
  end
end
