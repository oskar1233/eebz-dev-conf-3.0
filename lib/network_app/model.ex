defmodule NetworkApp.Model do
  @moduledoc """
  Context (Public API) for running predictions on our model.
  """

  defdelegate run(input), to: __MODULE__.Worker
end
