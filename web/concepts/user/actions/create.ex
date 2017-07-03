defmodule Unicorn.User.CreateAction do

  use Unicorn.Concept.Action

  alias Unicorn.User.{
    CreateQuery
  }

  def run(params \\ %{}) do
    with {:ok, params} <- model_create(params, with: CreateQuery) 
    do
      {:ok, params}
    else
      {:error, method, params} ->
        {:error, method, params}
    end
  end

end