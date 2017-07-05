defmodule Unicorn.User.CreateQuery do

  use Unicorn.Concept.Query

  alias Unicorn.User.{
    CreateContract
  }

  def run(options) do
    options
    |> CreateContract.run
    |> Repo.insert
  end

end