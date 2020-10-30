defmodule TaskManagerApi.Module.MyInitializer do
  use Rabbit.Initializer
  
  def start_link(opts \\ []) do
    Rabbit.Initializer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # Callbacks

  @impl Rabbit.Initializer
  def init(:initializer, opts) do
    # Perform runtime config
    {:ok, opts}
  end
end