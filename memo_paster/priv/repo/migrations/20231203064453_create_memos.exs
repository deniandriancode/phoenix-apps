defmodule MemoPaster.Repo.Migrations.CreateMemos do
  use Ecto.Migration

  def change do
    create table(:memos) do
      add :title, :string
      add :content, :text
      add :author_id, references(:authors)

      timestamps(type: :utc_datetime)
    end
  end
end
