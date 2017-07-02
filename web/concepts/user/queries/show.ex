defmodule Unicorn.User.ShowQuery do
  @moduledoc """
  Query to find a server by name
  """
  use Unicorn.Concept, :query

  def run(params) do
    Repo.get(Unicorn.UserModel, params[:id])
  end

end