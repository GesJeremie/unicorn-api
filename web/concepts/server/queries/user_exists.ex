defmodule Unicorn.Server.UserExistsQuery do

  use Unicorn.Concept.Query

  def run(params) do
    params
    |> query
    |> Repo.one
    |> count
  end

  defp query(params) do    
    from user in Unicorn.UserModel,
      select: count(user.id),
      where: user.token == ^params[:user_token]
  end

  defp count(0) do
    false
  end

  defp count(1) do
    true
  end

end