defmodule Unicorn.ServerModel do
  use Unicorn.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "servers" do
    field :name, :string
    field :current_track, :string

    belongs_to :user, Unicorn.Model
    timestamps()
  end

end