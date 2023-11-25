defmodule Kontact.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :phone, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create_unique_index(:contacts, [:email])
    create_unique_index(:contacts, [:phone])
    create_unique_index(:contacts, [:name, :email, :phone])
  end
end
