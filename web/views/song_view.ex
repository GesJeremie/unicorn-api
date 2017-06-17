defmodule Unicorn.SongView do
  use Unicorn.Web, :view

  attributes [:title, :thumbnail]

  @doc """
  We want the id to be the video id of youtube
  """
  def id(song, _conn) do
    song.video_id
  end
end