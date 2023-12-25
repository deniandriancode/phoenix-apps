defmodule DiscordMemo.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :username, :string
      add :token, :string

      timestamps(type: :utc_datetime)
    end
  end
end
