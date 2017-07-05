defmodule Unicorn.Server do
  use Unicorn.Web, :model

  schema "servers" do
    field :name, :string
    field :current_track, :string

    belongs_to :user, Unicorn.User
    timestamps()
  end

end