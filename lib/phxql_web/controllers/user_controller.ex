defmodule PhxQLWeb.UserController do
  use PhxQLWeb, :controller
  alias PhxQL.{Repo, Accounts, Accounts.User}

  plug(PhxQLWeb.Plugs.AuthenticateUser when action in [:index, :show])
  plug(:authorize_user when action in [:show])

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  defp authorize_user(conn, _params) do
    # Here `_params` are not the same as the `params` we get in the actions, so we need to fetch User ID manually.
    # If we working with one of [edit, update, delete] actions, we have that in URL param: /users/:id.
    # So all we need is to __Pattern Match__ it from our connection `conn`.
    %{params: %{"id" => user_id}} = conn
    user = Accounts.get_user!(user_id)
    current_user_id = conn.assigns.current_user.id

    if current_user_id == user.id do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to access that page!")
      |> redirect(to: Routes.user_path(conn, :show, current_user_id))
      |> halt()
    end
  end
end
