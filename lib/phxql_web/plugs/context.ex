defmodule PhxQLWeb.Plugs.Context do
  alias PhxQLWeb.Auth.Guardian, as: Guard

  import Plug.Conn

  def init(_opts) do
  end

  def call(conn, _opts) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user, _claims} <- Guard.resource_from_token(token) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end
