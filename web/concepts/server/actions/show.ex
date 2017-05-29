defmodule Unicorn.Server.ShowAction do
  @moduledoc """
  Action to show a server
  """
  use Unicorn.Web, :action

  alias Unicorn.Server.{
    ShowValidation,
    FindByNameQuery
  }

  def run(params) do
    with {:ok, params} <- validate(params),
         {:ok, params} <- find_unicorn(params)
    do
      {:ok, params}
    else
      {:error, method, params} ->
        {:error, method, params}
    end
  end

  def validate(params) do
    case ShowValidation.make(params) do
      {:ok, validation} ->
        {:ok, params}
      {:error, validation} ->
        params = Map.merge(params, %{validation: validation})
        {:error, :validate, params}
    end
  end

  defp find_unicorn(params) do
    case FindByNameQuery.run(%{name: params[:name]}) do
      nil ->
        {:error, :find_unicorn, params}

      model ->
        params = Map.merge(params, %{model: model})
        {:ok, params}
    end
  end

end