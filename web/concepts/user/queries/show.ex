defmodule Unicorn.User.ShowQuery do

  use Unicorn.Concept.Query

  def run(params) do
    Repo.get(Unicorn.UserModel, params[:id])
  end

end