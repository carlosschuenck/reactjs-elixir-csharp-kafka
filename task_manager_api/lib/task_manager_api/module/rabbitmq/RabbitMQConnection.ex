defmodule TaskManagerApi.Module.RabbitMQ.RabbitMQConnection do
  use Rabbit.Connection

  def start_link(opts \\ []) do
    Rabbit.Connection.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # Callbacks

  @impl Rabbit.Connection
  def init(:connection_pool, opts) do
    # Perform runtime pool config
    {:ok, opts}
  end

  def init(:connection, opts) do
    # Perform runtime connection config
    uri = System.get_env("RABBITMQ_URI") || "amqp://guest:guest@127.0.0.1:5672"
    opts = Keyword.put(opts, :uri, uri)

    {:ok, opts}
  end
end