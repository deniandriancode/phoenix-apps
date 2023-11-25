defmodule Kontact.Repo do
  use Ecto.Repo,
    otp_app: :kontact,
    adapter: Ecto.Adapters.Postgres
end
