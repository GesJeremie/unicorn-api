defmodule Unicorn.Server.CreateAction do
  @moduledoc """
  Action to create a server
  """
  use Unicorn.Concept, :action

  alias Unicorn.{
    MemorableNameHelper
  }

  alias Unicorn.Server.{
    NameExistsQuery,
    CreateQuery
  }

  def run(params \\ %{}) do
    with {:ok, params} <- find_unique_name(params),
         {:ok, params} <- save(params)
    do
      {:ok, params}
    else
      {:error, method, params} ->
        {:error, method, params}
    end
  end

  defp find_unique_name(params) do
    name = MemorableNameHelper.generate()
    exists = NameExistsQuery.run(%{name: name})

    unique_name_exists(exists, name, params)
  end

  defp unique_name_exists(true, _name, params) do
    # Retry until you find one available
    find_unique_name(params)
  end

  defp unique_name_exists(false, name, params) do
    params = Map.merge(params, %{unique_name: name})

    {:ok, params}
  end

  defp save(params) do
    case CreateQuery.run(%{name: params[:unique_name]}) do
      {:ok, model} ->
        params = Map.merge(params, %{model: model})
        {:ok, params}

      {:error, contract} ->
        params = Map.merge(params, %{contract: contract})
        {:error, :save, params}
    end
  end

end