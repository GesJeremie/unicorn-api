defmodule Unicorn.User.ShowQuery do

  use Unicorn.Concept.Query

  def run(options) do
    Unicorn.User
    |> Repo.get(options[:params][:id])
  end

end