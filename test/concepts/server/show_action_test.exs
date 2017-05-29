defmodule Unicorn.ShowActionTest do
  use Unicorn.ConnCase, async: true
  alias Unicorn.Server.{
    CreateAction,
    ShowAction
  }

  test "return existing server" do
    {_, server} = CreateAction.run()
    {success, result} = ShowAction.run(%{name: server[:model].name})

    assert success == :ok
    assert Map.has_key?(result, :model)
    assert result[:model].name == server[:model].name
  end

  test "fail when server doesn't exist" do
    result = ShowAction.run(%{name: "fake-name-server"})

    assert {:error, :find_unicorn, _} = result
  end

end