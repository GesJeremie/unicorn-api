defmodule Unicorn.Youtube.SearchAction do
  @moduledoc """
  Action to search music videos on youtube
  """
  require IEx;
  use Unicorn.Web, :action

  alias Unicorn.Server.{
  }

  def run(params) do
    with {:ok, params} <- make_search(params),
         {:ok, params} <- build_songs(params),
         {:ok, params} <- get_durations(params)
    do
      {:ok, params}
    else
      {:error, method, params} ->
        {:error, method, params}
    end
  end

  defp make_search(params) do
    request = HTTPoison.get "https://www.googleapis.com/youtube/v3/search", [], params: %{
      part: "snippet", 
      q: "haezer",
      key: "AIzaSyB7T2tSvrpH_L-GF2wzu62e2sfezISNw_k",
      type: "video",
      videoCategoryId: 10, # Music
      videoDuration: "short",
      order: "videoCount",
      maxResults: 50
    }

    case request do
      {:ok, response} ->
        params = Map.merge(params, %{result: response.body |> Poison.decode!})
        {:ok, params}
      _ ->
        {:error, :make_search, params}
    end
  end

  defp build_songs(params) do
    songs = params[:result]["items"] |> Enum.map(fn(item) -> Map.merge(item["id"], item["snippet"]) end)
    params = Map.merge(params, %{songs: songs})
    {:ok, params}
  end

  defp get_durations(params) do
    ids = 
      params[:songs] 
      |> Enum.map(fn(song) -> song["videoId"] end) 
      |> Enum.join(",")

    request = HTTPoison.get "https://www.googleapis.com/youtube/v3/videos", [], params: %{
      key: "AIzaSyB7T2tSvrpH_L-GF2wzu62e2sfezISNw_k",
      part: "contentDetails",
      id: ids
    }

    case request do
      {:ok, response} ->
        {:ok, params}
      _ ->
        {:error, :get_durations, params}
    end
  end

end