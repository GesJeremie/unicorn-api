defmodule Unicorn.User.ShowValidation do

  use Unicorn.Concept.Validation

  defp params(options) do
    %{
      id: options[:params][:id]
    }
  end

  defp params_types do
    %{
      id: Ecto.UUID
    }  
  end

  defp rules(changeset) do
    changeset
    |> validate_required([:id])
  end

end