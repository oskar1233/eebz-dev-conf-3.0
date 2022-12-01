defmodule NetworkApp.Repo do
  use Ecto.Repo,
    otp_app: :network_app,
    adapter: Ecto.Adapters.Postgres
end
