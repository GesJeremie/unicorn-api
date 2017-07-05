"""
defmodule Unicorn.ServerSong.CreateActionTest do
  use Unicorn.ConnCase, async: true
  alias Unicorn.ServerSong.CreateAction

  test "create server song" do
    song = %{
      youtube_code: "JdBZJVmQz-c",
      title: "Haezer - Smut Me [Electronic]",
      thumbnail: "https://i.ytimg.com/vi/JdBZJVmQz-c/hqdefault.jpg"
    }

    {success, result} = CreateAction.run(song)

    assert success == :ok
    assert Map.has_key?(result, :model)
  end

end
"""