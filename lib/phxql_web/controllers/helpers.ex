defmodule PhxQLWeb.Controllers.Helpers do
  import Plug.Conn

  # def redirect_back(conn, opts \\ []) do
  #   Phoenix.Controller.redirect(conn, to: NavigationHistory.last_path(conn))
  # end

  def redirect_back(conn, default \\ "/") do
    path =
      conn
      |> get_req_header("referer")
      |> referer

    path || default
  end

  defp referer([]), do: nil
  defp referer([h | _]), do: h
end
