defmodule PhxQL.Repo do
  use Ecto.Repo,
    otp_app: :phxql,
    adapter: Ecto.Adapters.Postgres
end
