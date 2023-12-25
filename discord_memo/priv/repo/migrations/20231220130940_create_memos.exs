defmodule DiscordMemo.Repo.Migrations.CreateMemos do
  use Ecto.Migration

  def change do
    create table(:memos) do
      add :title, :string
      add :content, :string
      add :author_id, references(:authors)

      timestamps(type: :utc_datetime)
    end
  end
end
