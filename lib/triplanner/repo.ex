defmodule Triplanner.Repo do
  use Ecto.Repo,
    otp_app: :triplanner,
    adapter: Ecto.Adapters.Postgres
end
