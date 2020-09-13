# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :task_manager_api,
  ecto_repos: [TaskManagerApi.Repo]

# Configures the endpoint
config :task_manager_api, TaskManagerApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mqyVfCgKmDhIi639uYNuC+tTzsrmWb1KuVzSFvaq0E6zR6Mu6OkpVvInLZC5Y4zm",
  render_errors: [view: TaskManagerApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TaskManagerApi.PubSub,
  live_view: [signing_salt: "7DN5XpR7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :kaffe,
  consumer: [
    endpoints: [localhost: 9092],
    topics: ["task_manager_topic"],
    consumer_group: "task_manager_group",
    message_handler: TaskManagerApi.MessageProcessor,
    offset_reset_policy: :reset_to_latest,
    max_bytes: 500_000,
    worker_allocation_strategy: :worker_per_topic_partition,
  ]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
