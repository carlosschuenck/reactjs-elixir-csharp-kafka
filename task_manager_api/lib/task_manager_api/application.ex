defmodule TaskManagerApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias TaskManagerApi.Module.RabbitMQ.{RabbitMQConnection, RabbitMQConsumerSupervisor}

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TaskManagerApi.Repo,
      # Start the Telemetry supervisor
      TaskManagerApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TaskManagerApi.PubSub},
      # Start the Endpoint (http/https)
      TaskManagerApiWeb.Endpoint,
      RabbitMQConnection,
      RabbitMQConsumerSupervisor
      # Start a worker by calling: TaskManagerApi.Worker.start_link(arg)
      # {TaskManagerApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TaskManagerApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TaskManagerApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
