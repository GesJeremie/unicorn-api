defmodule Unicorn.User.ShowAction do

  use Unicorn.Concept, :action

  alias Unicorn.User.{
    ShowValidation,
    ShowQuery
  }

  def run(params \\ %{}) do
    with  {:ok, params} <- Action.validate(params, with: ShowValidation),
          {:ok, params} <- Action.show(params, with: ShowQuery) 
    do
      {:ok, params}
    else
      {:error, method, params} ->
        {:error, method, params}
    end
  end

end