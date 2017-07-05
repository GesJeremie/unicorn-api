defmodule Unicorn.User.CreateContract do

  use Unicorn.Concept.Contract

  def run(options) do
    params = %{
      token: Ecto.UUID.generate
    }
  
    %Unicorn.User{}
    |> cast(params, [:token])
    |> validate_required([:token])
  end

end