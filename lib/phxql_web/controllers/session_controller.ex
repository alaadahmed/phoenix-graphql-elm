defmodule PhxQLWeb.SessionController do
  use PhxQLWeb, :controller
  alias PhxQL.Accounts.Auth

  def new(conn, _params) do
    if conn.assigns.user_signed_in? do
      current_user = conn.assigns.current_user

      conn
      |> put_flash(:info, "You already logged in, hello!")
      |> redirect(to: Routes.user_path(conn, :show, current_user.id))
    else
      render(conn, "new.html")
    end
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Auth.sign_in(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "You have successfully signed in")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid Email or Password!")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.sign_out()
    |> put_flash(:info, "You have signed out")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
