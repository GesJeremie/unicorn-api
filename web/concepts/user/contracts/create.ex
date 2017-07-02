defmodule Unicorn.User.CreateContract do

  use Unicorn.Concept, :contract

  def run(params \\ %{}) do
    %Unicorn.UserModel{}
    |> cast(params, [:token])
    |> validate_required([:token])
  end

end