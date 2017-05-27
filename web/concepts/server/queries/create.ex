defmodule Unicorn.Server.CreateQuery do
  use Unicorn.Web, :query

  alias Unicorn.Server.{
    CreateChangeset
  }

  def run(params) do
    changeset = changeset(params)

    Repo.insert(changeset)
  end

  def changeset(params) do
    CreateChangeset.cast(Unicorn.ServerModel, %{
      name: params[:name],
      token: Ecto.UUID.generate
    })
  end

end