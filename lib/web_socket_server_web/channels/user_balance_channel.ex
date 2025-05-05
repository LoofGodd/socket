defmodule WebSocketServerWeb.UserBalanceChannel do
  use WebSocketServerWeb, :channel
  require Logger
  @impl true
  def join("user:balance:" <> _user_id, _params, socket) do
    {:ok, socket}

    # if authorized?(socket.assigns[:params]) do
    #   {:ok, socket}
    # else
    #   {:error, %{reason: "unauthorized"}}
    # end
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

  # Add authorization logic here as required.
  # defp authorized?(payload) do
  #   case verify_token(payload["token"], payload["username"]) do
  #     {:ok, _value} -> true
  #     {:error, _value} -> false
  #   end
  # end

  # # Helper function to verify token using Finch
  # defp verify_token(token, username) do
  #   # Replace with your backend URL
  #   Application.get_env(:web_socket_server, :phoenix_secret)

  #   url =
  #     "#{Application.get_env(:web_socket_server, :backend_url)}/v1/verify-token?username=#{username}"

  #   headers = [{"Authorization", "Bearer #{token}"}]

  #   # Build and send the HTTP request with Finch
  #   request = Finch.build(:get, url, headers)
  #   Logger.info("Backend rejected token for username #{url} ")

  #   case Finch.request(request, WebSocketServer.Finch) do
  #     {:ok, %Finch.Response{status: status}} when status >= 400 ->
  #       Logger.info("Backend rejected token for username #{url}: HTTP #{status}")
  #       {:error, :invalid_token}

  #     {:ok, %Finch.Response{}} ->
  #       {:ok, :success}

  #     {:error, reason} ->
  #       Logger.error("Failed to reach backend: #{inspect(reason)}")
  #       {:error, :verification_failed}
  #   end
  # end
end
