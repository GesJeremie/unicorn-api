defmodule Unicorn.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def up do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :token, :string

      timestamps()
    end
  end

  def down do
    drop table(:users)
  end
end
