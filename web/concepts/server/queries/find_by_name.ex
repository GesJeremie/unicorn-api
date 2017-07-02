defmodule Unicorn.Server.FindByNameQuery do
  @moduledoc """
  Query to find a server by name
  """
  use Unicorn.Concept, :query

  def run(params) do
    params
    |> query
    |> Repo.one
  end

  defp query(params) do
    IO.inspect(params)
    from server in Unicorn.ServerModel,
      where: server.name == ^params[:name]
  end

end