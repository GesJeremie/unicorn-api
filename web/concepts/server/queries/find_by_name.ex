defmodule Unicorn.Server.FindByNameQuery do
  @moduledoc """
  Query to find a server by name
  """
  use Unicorn.Web, :query

  def run(params) do
    params
    |> query
    |> Repo.one
  end

  defp query(params) do
    from server in Unicorn.ServerModel,
      where: server.name == ^params[:name]
  end

end