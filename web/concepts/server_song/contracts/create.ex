defmodule Unicorn.ServerSong.CreateContract do
  @moduledoc """
  Contract when creating a server song
  """
  use Unicorn.Web, :contract

  def make(params \\ %{}) do
    %Unicorn.ServerSongModel{}
    |> cast(params, [:youtube_code, :title, :thumbnail])
    |> validate_required([:youtube_code, :title, :thumbnail])
  end

end