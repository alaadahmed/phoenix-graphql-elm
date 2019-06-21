defmodule PhxQL.Accounts.Auth do
  alias PhxQL.Repo
  alias PhxQL.Accounts.User

  def sign_in(email, password) do
    user = Repo.get_by(User, email: email)

    cond do
      user && Argon2.check_pass(user, password) ->
        {:ok, user}

      true ->
        {:error, :unauthorized}
    end
  end

  def sign_out(conn) do
    Plug.Conn.configure_session(conn, drop: true)
  end

  def register(params) do
    User.changeset(%User{}, params) |> Repo.insert()
  end
end
