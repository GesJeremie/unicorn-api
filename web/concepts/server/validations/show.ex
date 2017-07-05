defmodule Unicorn.Server.ShowValidation do

  use Unicorn.Concept.Validation

  schema "validation_show" do
    field :name, :string
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
    %Unicorn.Server.ShowValidation{}
    |> cast(params, [:name])
    |> validate_required([:name])
  end

end