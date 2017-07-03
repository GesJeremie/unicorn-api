defmodule Unicorn.Repo.Migrations.CreateServersTable do
  use Ecto.Migration

  def up do
    create table(:servers, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :user_id, references(:users, type: :uuid)
      add :current_track, :string

      timestamps()
    end
  end

  def down do
    drop table(:servers)
  end
end