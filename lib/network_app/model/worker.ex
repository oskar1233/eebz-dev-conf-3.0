defmodule NetworkApp.Model.Worker do
  use GenServer

  alias NetworkApp.Model.State

  @name __MODULE__

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  def init(_) do
    {:ok, State.init}
  end

  def run(input) do
    GenServer.call(@name, {:run, input}, :infinity)
  end

  def handle_call({:run, input}, _, state) do
    output = State.run(state, input)

    {:reply, output, state}
  end
end
