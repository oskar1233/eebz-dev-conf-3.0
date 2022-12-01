defmodule NetworkAppWeb.PageController do
  use NetworkAppWeb, :controller

  def index(conn, %{"image" => %{"image" => %{path: path}}}) do
    IO.inspect(%{path: path})

    tensor = load_tensor_from_file(path)

    predict = NetworkApp.Model.run(tensor)

    conn
    |> assign(:predict, predict)
    |> render("index.html")
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def load_tensor_from_file(file) do
    image = Image.open!(file)
    {:ok, tensor} = Image.to_nx(image)

    [normalize(tensor)]
    |> Nx.stack()
  end

  defp normalize(tensor) do
    tensor
    |> Nx.divide(Nx.tensor(255))
  end
end
