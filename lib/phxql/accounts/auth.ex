defmodule PhxQL.Accounts.Auth do
  import Ecto.Query
  alias PhxQL.Repo
  alias PhxQL.Accounts.User

  def sign_in(email, password) do
    query = from(u in User, where: u.email == ^email)

    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.check_pass(user, password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def sign_out(conn) do
    Plug.Conn.configure_session(conn, drop: true)
  end

  def register(params) do
    User.changeset(%User{}, params) |> Repo.insert()
  end
end
