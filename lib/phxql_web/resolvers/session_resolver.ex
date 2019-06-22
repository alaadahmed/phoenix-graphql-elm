defmodule PhxQLWeb.Resolvers.SessionResolver do
  alias PhxQL.Accounts.Auth
  alias PhxQLWeb.Auth.Guardian, as: Guard

  def login_user(_, %{input: %{email: email, password: password}}, _) do
    with {:ok, user} <- Auth.sign_in(email, password),
         {:ok, jwt_token, _} <- Guard.encode_and_sign(user) do
      {:ok, %{token: jwt_token, user: user}}
    end
  end
end
