defmodule Unicorn.Server.CreateChangeset do
  @moduledoc """
  Contract when creating a server
  """
  use Unicorn.Web, :changeset

  def cast(server, params \\ %{}) do
    server
    |> cast(params, [:name, :token])
    |> validate_required([:name, :token])
    |> unique_constraint(:name)
  end

end