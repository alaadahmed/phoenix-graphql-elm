defmodule PhxQLWeb.Resolvers.UserResolver do
  alias PhxQL.Accounts

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def register_user(_, %{input: params}, _) do
    Accounts.create_user(params)
  end
end
