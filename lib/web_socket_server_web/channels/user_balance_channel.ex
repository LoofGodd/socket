defmodule WebSocketServerWeb.UserBalanceChannel do
  use WebSocketServerWeb, :channel
  require Logger
  @impl true
  def join("user:balance:" <> _token, _params, socket) do
    {:ok, socket}
  end

  def join(_topic, _payload, _socket) do
    {:error, %{reason: "invalid topic"}}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (user_balance:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end
end
