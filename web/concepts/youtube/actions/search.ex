defmodule Unicorn.Youtube.SearchAction do
  @moduledoc """
  Action to search music videos on youtube
  """
  use Unicorn.Web, :action

  alias Unicorn.Youtube.{
    SearchValidation
  }

  @doc """
  Run the action

  ## Inputs
  ```
  %{
    # Search to perform
    # Required: true
    query: "Haezer - Control"
  }
  ```

  ## Outputs
  ```
  {:ok, result}

  # Where result is

  %{
    # The search results rendered by youtube
    :search,

    # The search durations results rendered by youtube 
    :search_durations, 

    # The songs results built based on the youtube results
    :songs
  }
  ```
  
  ## Errors 

  ```
  # Inputs invalid
  {:error, :validate, result}

  # Impossible to retrieve the results from youtube
  {:error, :make_search, result} 

  # Impossible to retrieve the duration results from youtube
  {:error, :make_search_durations, result}
  ```
  """
  def run(params) do
    with {:ok, params} <- validate(params),
         {:ok, params} <- make_search(params),
         {:ok, params} <- build_songs(params),
         {:ok, params} <- make_search_durations(params),
         {:ok, params} <- assoc_duration_songs(params)
    do
      {:ok, params}
    else
      {:error, method, params} ->
        {:error, method, params}
    end
  end

  ###
  # Pipeline
  ###
  
  defp validate(params) do
    case SearchValidation.make(params) do
      {:ok, validation} ->
        {:ok, params}
      {:error, validation} ->
        params = Map.merge(params, %{validation: validation})
        {:error, :validate, params}
    end
  end

  ###
  # Retrieve the results of youtube for the query string given
  ###
  defp make_search(params) do
    request = HTTPoison.get "https://www.googleapis.com/youtube/v3/search", [], params: %{
      part: "snippet", 
      q: params[:query],
      key: "AIzaSyB7T2tSvrpH_L-GF2wzu62e2sfezISNw_k",
      type: "video",
      videoCategoryId: 10, # Music
      videoDuration: "medium",
      videoEmbeddable: true,
      order: "relevance",
      maxResults: 50
    }

    case request do
      {:ok, response} ->
        params = Map.merge(params, %{search: response.body |> Poison.decode!})
        {:ok, params}
      _ ->
        {:error, :make_search, params}
    end
  end

  ###
  # Digest the youtube results to a simple struct
  ###
  defp build_songs(params) do
    songs = params[:search]["items"]
    songs = Enum.map(songs, &parse_song/1)

    params = Map.merge(params, %{songs: songs})

    {:ok, params}
  end

  ###
  # To get the durations of the search results, we need to do another query
  # to the youtube's API
  ###
  defp make_search_durations(params) do
    ids = collect_ids_songs(params[:songs])

    request = HTTPoison.get "https://www.googleapis.com/youtube/v3/videos", [], params: %{
      key: "AIzaSyB7T2tSvrpH_L-GF2wzu62e2sfezISNw_k",
      part: "contentDetails",
      id: ids
    }

    case request do
      {:ok, response} ->
        response = response.body |> Poison.decode!
        params = Map.merge(params, %{search_durations: response["items"]})
        {:ok, params}
      _ ->
        {:error, :make_search_durations, params}
    end
  end

  ###
  # Associate the durations to the results retrieved before
  ###
  defp assoc_duration_songs(params) do
    songs = 
      params[:search_durations]
      |> Enum.with_index
      |> Enum.map(fn({search_duration, index}) ->
          # Assoc duration
          duration = get_duration(search_duration)
          song = Enum.at(params[:songs], index)

          Enum.concat(song, %{duration: duration})
         end)

    params = Map.merge(params, %{songs: songs})

    {:ok, params}
  end

  ###
  # Helpers
  ###
  
  defp parse_song(search_song) do
    %{
      video_id: search_song["id"]["videoId"],
      title: search_song["snippet"]["title"],
      thumbnail: search_song["snippet"]["thumbnails"]["high"]["url"],
      published_at: search_song["snippet"]["publishedAt"]
    }
  end

  defp get_duration(search_duration) do
    search_duration["contentDetails"]["duration"]
  end

  defp collect_ids_songs(songs) do
    songs
    |> Enum.map(fn(song) -> song.video_id end)
    |> Enum.join(",")
  end

end