defmodule PhxQLWeb.Auth.ErrorHanlder do
  import Plug.Conn
  @behaviour Guardian.Plug.ErrorHandler

  def auth_error(conn, {:invalid_token, _reason}, _opts),
    do: response(conn, :unauthorized, "Invalid Token!")

  def auth_error(conn, {:unauthenticated, _reason}, _opts),
    do: response(conn, :unauthorized, "Not Authenticated!")

  def auth_error(conn, {:no_reason_found, _reason}, _opts),
    do: response(conn, :unauthorized, "No Resource Found!")

  def auth_error(conn, {type, _reason}, _opts),
    do: response(conn, :forbidden, to_string(type))

  defp response(conn, status, message) do
    body = Jason.encode!(%{error: message})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, body)
  end
end
