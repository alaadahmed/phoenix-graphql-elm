defmodule PhxQLWeb.RegisterController do
  use PhxQLWeb, :controller
  alias PhxQL.Accounts.Auth

  def new(conn, _params) do
    render(conn, "new.html", changeset: conn)
  end

  def create(conn, %{"registeration" => registration_params}) do
    case Auth.register(registration_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "You have successfully signed up!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
