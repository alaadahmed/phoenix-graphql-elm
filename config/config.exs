# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phxql,
  namespace: PhxQL,
  ecto_repos: [PhxQL.Repo]

# Configures the endpoint
config :phxql, PhxQLWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D412icOx2aPwA2/2jhUZSKpqxt9Jy2Pc8uTIiF24yvor+3+6cPQ6hURRURz9KzyF",
  render_errors: [view: PhxQLWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhxQL.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phxql, PhxQLWeb.Auth.Guardian,
  issuer: "phxql",
  verify_issuer: true,
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
