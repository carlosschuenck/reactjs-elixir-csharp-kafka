defmodule TaskManagerApi.Module.RabbitMQ.RabbitMQConsumerSupervisor do
  use Rabbit.ConsumerSupervisor

  alias TaskManagerApi.Module.TaskModule
  alias TaskManagerApi.Module.RabbitMQ.RabbitMQConnection

  def start_link(consumers \\ []) do
    Rabbit.ConsumerSupervisor.start_link(__MODULE__, consumers, name: __MODULE__)
  end

  # Callbacks

  @impl Rabbit.ConsumerSupervisor
  def init(:consumer_supervisor, _consumers) do
    # Perform runtime config for the consumer supervisor
    consumers = [
      [connection: RabbitMQConnection, queue: "hello", prefetch_count: 5],
    ]

    {:ok, consumers}
  end

  def init(:consumer, opts) do
    # Perform runtime config per consumer
    {:ok, opts}
  end

  @impl Rabbit.ConsumerSupervisor
  def handle_setup(channel, queue) do
    # Optional callback to perform any exchange or queue setup per consumer
    AMQP.Queue.declare(channel, queue)
    :ok
  end

  @impl Rabbit.ConsumerSupervisor
  def handle_message(message) do
    # Handle message consumption per consumer
    taks = TaskModule.findAllByUser(1)
    IO.inspect(taks)
    IO.puts("==========>> RabbitMQ consumer <<=============")
    IO.inspect(message.payload)
    {:ack, message}
  end

  @impl Rabbit.ConsumerSupervisor
  def handle_error(message) do
    # Handle message errors per consumer
    {:nack, message}
  end
end