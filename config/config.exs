# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :weather,
  ecto_repos: [Weather.Repo]

# Configures the endpoint
config :weather, WeatherWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rHE4hCbc2NMA42uNwobP3GVI8Cv8akknk9Ex5OKq1tXQY2df7XuHU/O0+QRB7Zgr",
  render_errors: [view: WeatherWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Weather.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
