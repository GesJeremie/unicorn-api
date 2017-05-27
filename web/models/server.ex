defmodule Unicorn.ServerModel do
  use Unicorn.Web, :model

  schema "servers" do
    field :name, :string
    field :token, :string

    timestamps()
  end

end