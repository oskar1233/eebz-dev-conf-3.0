defmodule NetworkAppWeb.PageController do
  use NetworkAppWeb, :controller

  def index(conn, %{"image" => %{"image" => %{path: path}}}) do
    predict = NetworkApp.PredictionRunner.run_prediction(path)

    conn
    |> assign(:predict, predict)
    |> render("index.html")
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
