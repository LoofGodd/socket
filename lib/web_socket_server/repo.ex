defmodule WebSocketServer.Repo do
  use Ecto.Repo,
    otp_app: :web_socket_server,
    adapter: Ecto.Adapters.SQLite3
end
