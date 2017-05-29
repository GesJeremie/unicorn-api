# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :unicorn,
  ecto_repos: [Unicorn.Repo]

# Configures the endpoint
config :unicorn, Unicorn.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "edMv7dv+4HyUNhVg/4krVYOexd9Pd+bJgMqERNwrF3qHYv80WNSSsGiVPk6L2Rel",
  render_errors: [view: Unicorn.ErrorView, accepts: ~w(json json-api)],
  pubsub: [name: Unicorn.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Api mime type
config :phoenix, :format_encoders,
  "json-api": Poison

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
