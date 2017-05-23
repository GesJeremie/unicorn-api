defmodule Unicorn.Router do
  use Unicorn.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Unicorn do
    pipe_through :api
    resources "session", SessionController, only: [:index]
  end
end
