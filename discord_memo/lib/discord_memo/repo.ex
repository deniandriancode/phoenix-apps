defmodule DiscordMemo.Repo do
  use Ecto.Repo,
    otp_app: :discord_memo,
    adapter: Ecto.Adapters.Postgres
end
