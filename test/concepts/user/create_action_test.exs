defmodule Unicorn.User.CreateActionTest do
  use Unicorn.ConnCase, async: true
  alias Unicorn.User.CreateAction

  test "create user" do
    {success, result} = CreateAction.run()

    assert success == :ok
    assert Map.has_key?(result, :model)
  end

end