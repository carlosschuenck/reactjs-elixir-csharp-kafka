defmodule MyConsumer do
  use Rabbit.Consumer

  def start_link(opts \\ []) do
    Rabbit.Consumer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # Callbacks

  @impl Rabbit.Consumer
  def init(:consumer, opts) do
    # Perform runtime config
    {:ok, opts}
  end

  @impl Rabbit.Consumer
  def handle_setup(channel, queue) do
    # Optional callback to perform any exchange or queue setup
    AMQP.Queue.declare(channel, queue)
    :ok
  end

  @impl Rabbit.Consumer
  def handle_message(message) do
    # Handle message consumption
    IO.inspect(message.payload)
    {:ack, message}
  end

  @impl Rabbit.Consumer
  def handle_error(message) do
    # Handle message errors
    {:nack, message}
  end
end

MyConsumer.start_link(connection: MyConnection, queue: "my_queue", prefetch_count: 10)
