defmodule ThumeWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", %{"body" => body, "username" => username}, socket) do
    broadcast!(socket, "new_message", %{body: body, username: username})
    {:noreply, socket}
  end
end
