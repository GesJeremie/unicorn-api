defmodule Unicorn.Server.CreateContract do
  @moduledoc """
  Contract when creating a server
  """
  use Unicorn.Concept.Contract

  def make(params \\ %{}) do
    IO.inspect params
    %Unicorn.Server{}
    |> cast(params, [:name, :user_id])
    |> validate_required([:name, :token])
    |> unique_constraint(:name)
  end

end