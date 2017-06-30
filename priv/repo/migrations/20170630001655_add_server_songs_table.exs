defmodule Unicorn.Repo.Migrations.ServerSongs do
  use Ecto.Migration

  def up do
    create table(:server_songs) do
      add :server_id, references(:servers)
      add :youtube_code, :string
      add :title, :string
      add :thumbnail, :string
      add :played, :boolean, default: false

      timestamps()
    end
  end

  def down do
    drop table(:server_songs)
  end
end
