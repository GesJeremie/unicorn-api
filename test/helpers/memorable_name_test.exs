defmodule Unicorn.MemorableNameHelperTest do
    
  use ExUnit.Case
  alias Unicorn.MemorableNameHelper

  describe "generate/0" do
    
    setup do
      {:ok, name: MemorableNameHelper.generate}
    end

    test "return binary", state do
      assert is_binary(state[:name])
    end

    test "return 3 segments", state do
      segments_length = state[:name] |> String.split("-") |> length

      assert segments_length == 3
    end

  end

end