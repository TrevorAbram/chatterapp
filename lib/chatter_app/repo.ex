defmodule ChatterApp.Repo do
  use Ecto.Repo,
    otp_app: :chatter_app,
    adapter: Ecto.Adapters.Postgres
end
