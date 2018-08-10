# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :subscriptionBackend,
  ecto_repos: [SubscriptionBackend.Repo]

# Configures the endpoint
config :subscriptionBackend, SubscriptionBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "p9RMRcbf2n/+LX2c+aAZ6fUWbQ0zrN3y48wYWFAxLr+CSoD/GxmLZASFnSZ1iE1X",
  render_errors: [view: SubscriptionBackendWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SubscriptionBackend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
