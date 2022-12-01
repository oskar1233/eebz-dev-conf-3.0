defmodule NetworkApp.Model.State do
  @model_file "./priv/model"
  @model_state_file "./priv/model_state"

  def init do
    model = File.read!(@model_file) |> :erlang.binary_to_term()
    model_state = File.read!(@model_state_file) |> Nx.deserialize()

    {_init_fn, predict_fn} = Axon.build(model)

    %{predict_fn: predict_fn, model_state: model_state}
  end

  def run(%{predict_fn: predict_fn, model_state: model_state}, input) do
    output = predict_fn.(model_state, input)
  end
end
