defmodule Unicorn.Server.CreateQuery do
  @moduledoc """
  Query to create a new server
  """
  use Unicorn.Concept.Query

  alias Unicorn.Server.{
    CreateContract
  }

  def run(params) do
    params
    |> contract
    |> Repo.insert
  end

  def contract(params) do
    CreateContract.make(%{
      name: params[:name],
      token: Ecto.UUID.generate
    })
  end

end