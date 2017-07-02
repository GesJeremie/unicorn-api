defmodule Unicorn.User.ShowValidation do

  use Unicorn.Concept, :validation

  @inputs %{
    id: Ecto.UUID
  }

  def run(params) do
    validation = validate(params)

    if validation.valid? do
      {:ok, validation}
    else
      {:error, validation}
    end
  end

  defp validate(params \\ %{}) do
    {%{}, @inputs}
    |> cast(params, Map.keys(@inputs))
    |> validate_required([:id])
  end

end