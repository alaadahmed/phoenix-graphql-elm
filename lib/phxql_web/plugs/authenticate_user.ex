defmodule PhxQLWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  alias PhxQLWeb.Router.Helpers, as: Routes

  def init(_opts) do
  end

  def call(conn, _opts) do
    if conn.assigns.user_signed_in? do
      conn
    else
      conn
      |> put_flash(:error, "You need to sign in or sign up before continuing.")
      |> redirect(to: Routes.user_session_path(conn, :new))
      |> halt()
    end
  end
end
