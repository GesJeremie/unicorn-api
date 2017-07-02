defmodule Unicorn.User.CreateQuery do

  use Unicorn.Concept, :query

  alias Unicorn.User.{
    CreateContract
  }

  def run(params) do
    params
    |> contract
    |> Repo.insert
  end

  def contract(params) do
    CreateContract.run(%{
      token: Ecto.UUID.generate
    })
  end

end