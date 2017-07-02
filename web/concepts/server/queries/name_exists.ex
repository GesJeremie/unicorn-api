defmodule Unicorn.Server.NameExistsQuery do
  @moduledoc """
  Query to check if a server name already exists
  """
  use Unicorn.Concept, :query

  def run(params) do
    params
    |> query
    |> Repo.one
    |> count
  end

  defp query(params) do    
    from server in Unicorn.ServerModel,
      select: count(server.id),
      where: server.name == ^params[:name]
  end

  defp count(0) do
    false
  end

  defp count(1) do
    true
  end

end