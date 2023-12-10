defmodule MemoPaster.Memos do
  @moduledoc """
  The Memos context.
  """

  import Ecto.Query, warn: false
  alias MemoPaster.Repo

  alias MemoPaster.Memos.Memo

  @doc """
  Returns the list of memos.

  ## Examples

      iex> list_memos()
      [%Memo{}, ...]

  """
  def list_memos do
    Repo.all(Memo)
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
    %Memo{}
    |> Memo.changeset(attrs)
    |> Repo.insert()
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
    memo
    |> Memo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a memo.

  ## Examples

      iex> delete_memo(memo)
      {:ok, %Memo{}}

      iex> delete_memo(memo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_memo(%Memo{} = memo) do
    Repo.delete(memo)
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

  alias MemoPaster.Memos.Author

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
  def create_memo_author(memo, author) do
    author = Repo.preload(author, [:memos])
    author_changeset = Ecto.Changeset.change(author)
    memo_changeset = Ecto.Changeset.cast(%Memo{}, memo, [:title, :content])
    memos = [memo_changeset | author.memos]
    author_memo_changeset = author_changeset |> Ecto.Changeset.put_assoc(:memos, memos)
    rep = Repo.update!(author_memo_changeset)
    Enum.at(rep.memos, 0)
  end

  @doc false
  def get_author_by_name(name) do
    Repo.get_by!(Author, name: name)
  end
end
