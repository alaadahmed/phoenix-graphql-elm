defmodule PhxQLWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :olx,
    module: PhxQLWeb.Auth.Guardian,
    error_handler: PhxQLWeb.Auth.ErrorHanlder

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
