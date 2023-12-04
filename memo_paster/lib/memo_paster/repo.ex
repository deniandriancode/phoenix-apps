defmodule MemoPaster.Repo do
  use Ecto.Repo,
    otp_app: :memo_paster,
    adapter: Ecto.Adapters.Postgres
end
