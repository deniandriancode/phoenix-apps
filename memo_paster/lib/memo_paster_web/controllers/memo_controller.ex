defmodule MemoPasterWeb.MemoController do
  use MemoPasterWeb, :controller

  alias MemoPaster.{Memos, Repo}
  alias MemoPaster.Memos.Memo

  def index(conn, _params) do
    memos = Memos.list_memos()
    render(conn, :index, memos: memos)
  end

  def new(conn, _params) do
    changeset = Memos.change_memo(%Memo{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"memo" => memo_params}) do
    case Memos.create_memo(memo_params) do
      {:ok, memo} ->
        conn
        |> put_flash(:info, "Memo created successfully.")
        |> redirect(to: ~p"/memos/#{memo}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    memo = Memos.get_memo!(id)
    render(conn, :show, memo: memo)
  end

  def edit(conn, %{"id" => id}) do
    memo = Memos.get_memo!(id)
    changeset = Memos.change_memo(memo)
    render(conn, :edit, memo: memo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "memo" => memo_params}) do
    memo = Memos.get_memo!(id)

    case Memos.update_memo(memo, memo_params) do
      {:ok, memo} ->
        conn
        |> put_flash(:info, "Memo updated successfully.")
        |> redirect(to: ~p"/memos/#{memo}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, memo: memo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    memo = Memos.get_memo!(id)
    {:ok, _memo} = Memos.delete_memo(memo)

    conn
    |> put_flash(:info, "Memo deleted successfully.")
    |> redirect(to: ~p"/memos")
  end

  def user_new(conn, _params) do
    changeset = Memos.change_memo(%Memo{})
    render(conn, :user_new, changeset: changeset)
  end

  def user_post(conn, %{"memo" => memo}) do
    if memo["username"] == "admin" and memo["password"] == "admin" do
      author = Memos.get_author!(3)
      memo_atom = for {key, val} <- memo, into: %{}, do: {String.to_atom(key), val}
      memo_struct = struct(Memo, memo_atom)
      Memos.create_memo_author(memo_atom, author)
      # |> put_flash(:info, "Memo created successfully.")
      redirect(conn, to: ~p(/memos))
      # case Memos.create_memo(memo) do
      #   {:ok, m} ->
      #     conn
      #     |> put_flash(:info, "Memo created successfully.")
      #     |> redirect(to: ~p"/memos/#{m}")
      #
      #   {:error, %Ecto.Changeset{} = changeset} ->
      #     put_flash(conn, :error, "Memo cannot be created.")
      #     render(conn, :new, changeset: changeset)
      # end
    end
    # put_flash(conn, :error, "You are not an authorized user.")
    redirect(conn, to: ~p"/memos/user/new")
  end

  def user_author_assoc(conn, %{"id" => _id}) do
    author = Memos.get_author!(3)
    author = Repo.preload(author, [:memos])
    IO.inspect author
    memos = author.memos
    render(conn, :index, memos: memos)
  end
end
