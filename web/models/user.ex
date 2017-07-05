defmodule Unicorn.User do
  use Unicorn.Web, :model

  schema "users" do
    field :token, :string

    has_many :servers, Unicorn.Server

    timestamps()
  end

end