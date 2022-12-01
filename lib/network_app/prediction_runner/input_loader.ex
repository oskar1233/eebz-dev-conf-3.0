defmodule NetworkApp.PredictionRunner.InputLoader do
  def load_input(path) do
    load_tensor_from_file(path_to_input)
  end

  defp load_tensor_from_file(file) do
    image = Image.open!(file)
    {:ok, tensor} = Image.to_nx(image)

    normalize(tensor)
    |> Nx.new_axis(-4)
  end

  defp normalize(tensor) do
    tensor
    |> Nx.divide(Nx.tensor(255))
  end
end
