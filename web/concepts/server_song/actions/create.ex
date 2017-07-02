defmodule Unicorn.ServerSong.CreateAction do
  @moduledoc """
  Action to create a server song
  """
  use Unicorn.Concept, :action

  alias Unicorn.{}

  alias Unicorn.ServerSong.{
    CreateValidation,
    CreateQuery
  }

  def run(params \\ %{}) do
    with  {:ok, params} <- save(params)
    do
      {:ok, params}
    else
      {:error, method, params} ->
        {:error, method, params}
    end
  end

  defp save(params) do
    case CreateQuery.run(params) do
      {:ok, model} ->
        params = Map.merge(params, %{model: model})
        {:ok, params}

      {:error, contract} ->
        params = Map.merge(params, %{contract: contract})
        {:error, :save, params}
    end
  end

end