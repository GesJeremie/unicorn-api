defmodule Unicorn.Server.Helpers do
  
  alias Unicorn.{
    MemorableNameHelper
  }

  alias Unicorn.Server.{
    NameExistsQuery
  }

  def generate_unique_name do
    name = MemorableNameHelper.generate()
    exists = NameExistsQuery.run(%{name: name})

    unique_name_exists(exists, name)
  end

  defp unique_name_exists(true, _name) do
    # Retry until you find one available
    generate_unique_name
  end

  defp unique_name_exists(false, name) do
    name
  end
end