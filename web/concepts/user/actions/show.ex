defmodule Unicorn.User.ShowAction do

  use Unicorn.Concept.Action

  alias Unicorn.User.{
    ShowValidation,
    ShowQuery
  }

  def run(params \\ %{}) do
    options = init_options(params)

    with {:ok, options} <- validate(options, with: ShowValidation),
         {:ok, options} <- model(:find, options, with: ShowQuery) 
    do
      {:ok, options}
    else
      {:error, method, options} ->
        {:error, method, options}
    end
  end

end