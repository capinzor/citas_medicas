defmodule CitasApp.Repo do
  use Ecto.Repo,
    otp_app: :citas_app,
    adapter: Ecto.Adapters.Postgres
end
