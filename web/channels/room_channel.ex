defmodule Unicorn.RoomChannel do
  use Unicorn.Web, :channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end
  
  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_song", params, socket) do
    broadcast! socket, "new_song", params
    {:noreply, socket}
  end

  def handle_in("new_device", params, socket) do
    broadcast! socket, "new_device", params
    {:noreply, socket}
  end

end