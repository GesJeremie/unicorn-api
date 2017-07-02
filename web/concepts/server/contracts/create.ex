defmodule Unicorn.Server.CreateContract do
  @moduledoc """
  Contract when creating a server
  """
  use Unicorn.Concept, :contract

  def make(params \\ %{}) do
    %Unicorn.ServerModel{}
    |> cast(params, [:name, :token])
    |> validate_required([:name, :token])
    |> unique_constraint(:name)
  end

end