defmodule Unicorn.Server.CreateValidation do

  use Unicorn.Concept.Validation

  defp cast_as do
    %{
      user_token: Ecto.UUID
    }  
  end

  defp validations(changeset) do
    changeset
    |> validate_required([:user_token])  
  end

end