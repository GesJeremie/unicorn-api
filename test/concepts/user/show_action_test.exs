defmodule Unicorn.User.ShowActionTest do
  use Unicorn.ConnCase, async: true
  alias Unicorn.User.{CreateAction, ShowAction}

  test "show user" do
    # Create User
    {:ok, %{:model => user}} = CreateAction.run()

    {success, result} = ShowAction.run(%{id: user.id})

    assert success == :ok
    assert Map.has_key?(result, :model)
  end

  test "validation error when no id given" do
    assert {:error, :validate, %{:validation => validation}} = ShowAction.run(%{})
  end

  test "model find error when id doesn't exist" do

    # Generate fake UUID
    id = Ecto.UUID.generate

    assert {:error, :model_find, result} = ShowAction.run(%{id: id})
  end

end