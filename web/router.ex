defmodule Unicorn.Router do
  use Unicorn.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/v1", Unicorn do
    pipe_through :api

    resources "/users", UserController, only: [:create, :show]
  end
end
