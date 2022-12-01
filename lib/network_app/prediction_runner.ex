defmodule NetworkApp.PredictionRunner do
  @moduledoc """
  User story for running predictions.
  """
  def run_prediction(path_to_input) do
    with loaded_input <- __MODULE__.InputLoader.load_input(path_to_input),
         output <- __MODULE__.ModelRunner.run(loaded_input) do
      output
    end
  end
end
