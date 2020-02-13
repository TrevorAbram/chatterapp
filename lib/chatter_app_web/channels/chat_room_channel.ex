defmodule ChatterAppWeb.ChatRoomChannel do
  use ChatterAppWeb, :channel

  def join("chat_room:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("new_message", payload, socket) do
    spawn(fn -> save_message(payload) end)
    broadcast! socket, "new_message", payload
    {:no_reply, socket}
  end



  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat_room:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  defp save_message(message) do
    ChatterAppWeb.Message.changeset(%ChatterApp.Message{}, message)
    |> ChatterAppWeb.Repo.insert
  end
end
