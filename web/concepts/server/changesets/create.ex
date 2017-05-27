defmodule Unicorn.Server.CreateChangeset do
  use Unicorn.Web, :changeset

  def cast(server, params \\ %{}) do
    server
    # Error because not new version of ecto
    # this is a new API introduced in the latest version
    # I have to update.
    |> validate_required([:name, :token])
    |> unique_constraint(:name)
  end

end