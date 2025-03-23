# lib/my_app_web/controllers/balance_update_controller.ex
defmodule WebSocketServerWeb.BalanceUpdateController do
  use WebSocketServerWeb, :controller

  # Add basic authentication
  plug :authorize when action in [:update]

  def update(conn, %{"user_id" => user_id, "balance" => balance}) do
    WebSocketServerWeb.Endpoint.broadcast("user:balance:#{user_id}", "balance_updated", %{
      balance: balance
    })

    send_resp(conn, :no_content, "")
  end

  defp authorize(conn, _opts) do
    expected_token = "Bearer #{Application.get_env(:web_socket_server, :phoenix_secret)}"
    IO.inspect(get_req_header(conn, "authorization") == [expected_token])

    if get_req_header(conn, "authorization") == [expected_token] do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Unauthorized"})
      |> halt()
    end
  end
end
