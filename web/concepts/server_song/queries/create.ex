defmodule Unicorn.ServerSong.CreateQuery do
  @moduledoc """
  Query to create a new server song
  """
  use Unicorn.Concept.Query

  alias Unicorn.ServerSong.{
    CreateContract
  }

  def run(params) do
    params
    |> contract
    |> Repo.insert
  end

  def contract(params) do
    CreateContract.make(%{
      youtube_code: params[:youtube_code],
      title: params[:title],
      thumbnail: params[:thumbnail]
    })
  end

end