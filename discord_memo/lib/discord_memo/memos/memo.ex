defmodule DiscordMemo.Memos.Memo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "memos" do
    field :title, :string
    field :content, :string
    field :token, :string, virtual: true
    belongs_to :author, DiscordMemo.Memos.Author

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(memo, attrs) do
    memo
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end

  @doc false
  def changeset_create(memo, attrs) do
    memo
    |> cast(attrs, [:title, :content, :token])
    |> validate_required(attrs, [:title, :content, :token])
  end
end
