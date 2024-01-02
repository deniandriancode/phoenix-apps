defmodule Thume.Repo do
  use Ecto.Repo,
    otp_app: :thume,
    adapter: Ecto.Adapters.Postgres
end
