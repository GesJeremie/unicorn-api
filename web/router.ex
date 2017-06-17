defmodule Unicorn.Router do
  use Unicorn.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/", Unicorn do
    pipe_through :api

    post "/servers", ServerController, :create
    get "/servers/:name", ServerController, :show

    get "/songs", SongController, :index
  end
end
