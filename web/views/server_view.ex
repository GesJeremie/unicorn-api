defmodule Unicorn.ServerView do
  use Unicorn.Web, :view

  attributes [:id, :name, :token, :inserted_at, :updated_at]

  @doc """
  We want the id to be the name of the server
  """
  def id(server, _conn) do
    server.name
  end
end