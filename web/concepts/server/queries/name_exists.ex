defmodule Unicorn.Server.NameExistsQuery do
  @moduledoc """
  Query to check if a server name already exists
  """
  use Unicorn.Web, :query

  def run(params) do
    query = query(params)

    if Repo.one(query) == 0, do: false, else: true
  end

  defp query(params) do
    from server in Unicorn.ServerModel,
      select: count(server.id),
      where: server.name == ^params[:name]
  end

end