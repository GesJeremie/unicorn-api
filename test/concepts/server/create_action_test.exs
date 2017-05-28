defmodule Unicorn.CreateActionTest do
  use Unicorn.ConnCase, async: true
  alias Unicorn.Server.CreateAction

  test "create server" do
    {success, result} = CreateAction.run()

    assert success == :ok
    assert Map.has_key?(result, :model)
  end

end