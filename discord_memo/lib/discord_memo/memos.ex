defmodule DiscordMemo.Memos do
  @moduledoc """
  The Memos context.
  """

  import Ecto.Query, warn: false
  alias DiscordMemo.Repo

  alias DiscordMemo.Memos.Memo

  @doc """
  Returns the list of memos.

  ## Examples

      iex> list_memos()
      [%Memo{}, ...]

  """
  def list_memos do
    Repo.all(Memo)
    |> Enum.sort_by(&(&1.id))
    |> Enum.map(&get_memo_author/1)
  end

  defp get_memo_author(memo) do
    memo = Repo.preload(memo, :author) |> Map.from_struct |> Map.drop([:token, :__meta__, :author_id, :inserted_at, :updated_at])
    memo_author = Map.from_struct memo[:author] |> Map.drop([:memos, :__meta__, :inserted_at, :updated_at])
    memo = Map.put(memo, :author, memo_author)
    memo
  end

  @doc """
  Gets a single memo.

  Raises `Ecto.NoResultsError` if the Memo does not exist.

  ## Examples

      iex> get_memo!(123)
      %Memo{}

      iex> get_memo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_memo!(id), do: Repo.get!(Memo, id)

  @doc """
  Creates a memo.

  ## Examples

      iex> create_memo(%{field: value})
      {:ok, %Memo{}}

      iex> create_memo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_memo(attrs \\ %{}) do
    author = get_author_by_token!(attrs["token"])
    memo_atom = for {key, val} <- attrs, into: %{}, do: {String.to_atom(key), val}
    memo_rec = create_memo_author(memo_atom, author)
    {:ok, memo_rec}
  end

  @doc false
  defp create_memo_author(memo, author) do
    author = Repo.preload(author, [:memos])
    author_changeset = Ecto.Changeset.change(author)
    memo_changeset = Ecto.Changeset.cast(%Memo{}, memo, [:title, :content])
    memos = [memo_changeset | author.memos]
    author_memo_changeset = author_changeset |> Ecto.Changeset.put_assoc(:memos, memos)
    rep = Repo.update!(author_memo_changeset)
    Enum.at(rep.memos, 0)
  end

  @doc """
  Updates a memo.

  ## Examples

      iex> update_memo(memo, %{field: new_value})
      {:ok, %Memo{}}

      iex> update_memo(memo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_memo(%Memo{} = memo, attrs) do
    author_token = attrs["token"]
    memo = Repo.preload(memo, [:author])
    if memo.author.token == author_token do
      memo
      |> Memo.changeset(attrs)
      |> Repo.update()
    else
      {:ok, %Memo{}}
    end
  end

  @doc """
  Deletes a memo.

  ## Examples

      iex> delete_memo(memo)
      {:ok, %Memo{}}

      iex> delete_memo(memo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_memo(%Memo{} = memo, conn) do
    query_params = conn.query_params
    author_token = query_params["token"]
    memo = Repo.preload(memo, [:author])
    if author_token == memo.author.token do
      Repo.delete(memo)
    else
      {:error, %Memo{}}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking memo changes.

  ## Examples

      iex> change_memo(memo)
      %Ecto.Changeset{data: %Memo{}}

  """
  def change_memo(%Memo{} = memo, attrs \\ %{}) do
    Memo.changeset(memo, attrs)
  end

  alias DiscordMemo.Memos.Author

  @doc """
  Get total record of memos
  """
  def count_memo do
    query = from m in Memo, select: count(m.id)
    res = Repo.all query
    res |> Enum.at(0)
  end

  @doc """
  Returns the list of authors.

  ## Examples

      iex> list_authors()
      [%Author{}, ...]

  """
  def list_authors do
    Repo.all(Author)
  end

  @doc """
  Gets a single author.

  Raises `Ecto.NoResultsError` if the Author does not exist.

  ## Examples

      iex> get_author!(123)
      %Author{}

      iex> get_author!(456)
      ** (Ecto.NoResultsError)

  """
  def get_author!(id), do: Repo.get!(Author, id)

  @doc """
  Creates a author.

  ## Examples

      iex> create_author(%{field: value})
      {:ok, %Author{}}

      iex> create_author(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a author.

  ## Examples

      iex> update_author(author, %{field: new_value})
      {:ok, %Author{}}

      iex> update_author(author, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a author.

  ## Examples

      iex> delete_author(author)
      {:ok, %Author{}}

      iex> delete_author(author)
      {:error, %Ecto.Changeset{}}

  """
  def delete_author(%Author{} = author) do
    Repo.delete(author)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking author changes.

  ## Examples

      iex> change_author(author)
      %Ecto.Changeset{data: %Author{}}

  """
  def change_author(%Author{} = author, attrs \\ %{}) do
    Author.changeset(author, attrs)
  end

  @doc false
  defp get_author_by_token!(token) do
    Repo.get_by!(Author, token: token)
  end
end
