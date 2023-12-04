defmodule MemoPaster.Memos.Memo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "memos" do
    field :title, :string
    field :content, :string
    field :username, :string, virtual: true
    field :password, :string, virtual: true
    belongs_to :author, MemoPaster.Memos.Author

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(memo, attrs) do
    memo
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
