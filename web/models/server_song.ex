defmodule Unicorn.ServerSongModel do
  use Unicorn.Web, :model

  schema "server_songs" do
    field :youtube_code, :string
    field :title, :string
    field :thumbnail, :string
    field :played, :boolean

    timestamps()
  end

end