defmodule Unicorn.User.ShowAction do

  use Unicorn.Concept.Action

  alias Unicorn.User.{
    ShowValidation,
    ShowQuery
  }

  def run(params \\ %{}) do
    with  {:ok, params} <- validate(params, with: ShowValidation),
          {:ok, params} <- model_find(params, with: ShowQuery) 
    do
      {:ok, params}
    else
      {:error, method, params} ->
        {:error, method, params}
    end
  end

end