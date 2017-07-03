defmodule Unicorn.User.ShowValidation do

  use Unicorn.Concept.Validation

  defp cast_as do
    %{
      id: Ecto.UUID
    }  
  end

  defp validations(changeset) do
    changeset
    |> validate_required([:id])  
  end

end