defmodule Unicorn.User.CreateAction do

  use Unicorn.Concept, :action

  alias Unicorn.User.{
    CreateValidation,
    CreateQuery
  }

  def run(params \\ %{}) do
    with {:ok, params} <- Action.create(params, with: CreateQuery) do
      {:ok, params}
    else
      {:error, method, params} ->
        {:error, method, params}
    end
  end

end