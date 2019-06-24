defmodule PhxQLWeb.Plugs.SetCurrentUser do
  import Plug.Conn

  alias PhxQL.Repo
  alias PhxQL.Accounts.User

  def init(_opts) do
  end

  def call(conn, _opts) do
    user_id = get_session(conn, :current_user_id)

    cond do
      current_user = user_id && Repo.get(User, user_id) ->
        conn
        |> assign(:current_user, current_user)
        |> assign(:user_signed_in?, true)

      true ->
        conn
        |> assign(:current_user, nil)
        |> assign(:user_signed_in?, false)
    end
  end
end
