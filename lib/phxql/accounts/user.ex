defmodule PhxQL.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string, unique: true)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:role, :string, default: "user")

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :role])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :password,
      :role
    ])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6, max: 100)
    |> put_hash_pass
  end

  defp put_hash_pass(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_hash_pass(changeset), do: changeset
end
