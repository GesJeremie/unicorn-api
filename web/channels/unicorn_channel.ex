defmodule Unicorn.UnicornChannel do
  use Unicorn.Web, :channel

  def join("unicorn:" <> name, _params, socket) do
    {:ok, socket}
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