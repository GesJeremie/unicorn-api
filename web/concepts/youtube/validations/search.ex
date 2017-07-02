defmodule Unicorn.Youtube.SearchValidation do
  @moduledoc """
  Validation params of action search
  """
  """
  use Unicorn.Concept, :validation

  schema "validation_search" do
    field :query, :string
  end

  def make(params) do
    validation = do_validation(params)

    if validation.valid? do
      {:ok, validation}
    else
      {:error, validation}
    end
  end

  defp do_validation(params \\ %{}) do
    %Unicorn.Youtube.SearchValidation{}
    |> cast(params, [:query])
    |> validate_required([:query])
  end
  """

end