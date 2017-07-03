defmodule Unicorn.UserModel do
  use Unicorn.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "users" do
    field :token, :string

    timestamps()
  end

end