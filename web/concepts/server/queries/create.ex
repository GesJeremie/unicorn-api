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
    IO.inspect params
    CreateContract.make(%{
      name: params[:name],
      user_id: params[:user_id]
    })
  end

end