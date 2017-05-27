defmodule Unicorn.Repo.Migrations.AddServersTable do
  use Ecto.Migration

  def up do
    create table(:servers) do
      add :name, :string
      add :token, :string
      
      timestamps()
    end
  end

  def down do
    drop table(:servers)
  end
end
