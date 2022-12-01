defmodule NetworkApp.Model do
  use GenServer

  @name __MODULE__

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  def init(_) do
    model = File.read!("./priv/model") |> :erlang.binary_to_term()
    model_state = File.read!("./priv/model_state") |> Nx.deserialize()

    {_init_fn, predict_fn} = Axon.build(model)

    state = %{predict_fn: predict_fn, model_state: model_state}

    {:ok, state}
  end

  def run(input) do
    GenServer.call(@name, {:run, input}, :infinity)
  end

  def handle_call({:run, input}, _, %{predict_fn: predict_fn, model_state: model_state} = state) do
    output = predict_fn.(model_state, input)

    {:reply, output, state}
  end
end
