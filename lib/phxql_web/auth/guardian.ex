defmodule PhxQLWeb.Auth.Guardian do
  use Guardian, otp_app: :phxql
  alias PhxQL.{Accounts, Accounts.User}

  def subject_for_token(%User{} = user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def subject_for_token(_, _), do: {:error, :reason_for_error}

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end

  def resource_from_claims(_claims), do: {:error, :reason_for_error}
end
