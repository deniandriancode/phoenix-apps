defmodule DiscordMemo.Memos.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :token, :string
    field :username, :string
    has_many :memos, DiscordMemo.Memos.Memo

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:username, :token])
    |> validate_required([:username, :token])
    |> unique_constraint(:token)
  end
end
