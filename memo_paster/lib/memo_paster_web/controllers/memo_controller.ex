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

  def create(conn, %{"memo" => memo}) do
    case [memo["username"], memo["password"]] do
      ["deni", "wawaw_hunter"] ->
        author = Memos.get_author_by_name("deniAndrian")
        memo_atom = for {key, val} <- memo, into: %{}, do: {String.to_atom(key), val}
        memo_rec = Memos.create_memo_author(memo_atom, author)
        conn
        |> put_flash(:info, "Memo created successfully.")
        |> redirect(to: ~p[/memos/#{memo_rec.id}])
      ["marcsha", "wawaw_hunter"] ->
        author = Memos.get_author_by_name("MarkSjaer")
        memo_atom = for {key, val} <- memo, into: %{}, do: {String.to_atom(key), val}
        memo_rec = Memos.create_memo_author(memo_atom, author)
        conn
        |> put_flash(:info, "Memo created successfully.")
        |> redirect(to: ~p[/memos/#{memo_rec.id}])
      ["wildan", "wawaw_hunter"] ->
        author = Memos.get_author_by_name("Aeshma")
        memo_atom = for {key, val} <- memo, into: %{}, do: {String.to_atom(key), val}
        memo_rec = Memos.create_memo_author(memo_atom, author)
        conn
        |> put_flash(:info, "Memo created successfully.")
        |> redirect(to: ~p[/memos/#{memo_rec.id}])
      _ ->
        conn
        |> put_flash(:error, "Username or password is incorrect.")
        |> redirect(to: ~p[/memos/new])
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

  def user_author_assoc(conn, %{"id" => id}) do
    author = Memos.get_author!(id)
    author = Repo.preload(author, [:memos])
    memos = author.memos
    render(conn, :index, memos: memos)
  end

  def user_author_assoc_api(conn, %{"id" => id}) do
    author = Memos.get_author!(id)
    author = Repo.preload(author, [:memos])
    memos = author.memos
    render(conn, :index, memos: memos)
  end

  def user_post_api(conn, %{"memo" => memo}) do
    case [memo["username"], memo["password"]] do
      ["deni", "wawaw_hunter"] ->
        author = Memos.get_author_by_name("deniAndrian")
        memo_atom = for {key, val} <- memo, into: %{}, do: {String.to_atom(key), val}
        memo_rec = Memos.create_memo_author(memo_atom, author)
        conn
        |> render(:show, %{memo: %Memo{}})
      ["marcsha", "wawaw_hunter"] ->
        author = Memos.get_author_by_name("MarkSjaer")
        memo_atom = for {key, val} <- memo, into: %{}, do: {String.to_atom(key), val}
        memo_rec = Memos.create_memo_author(memo_atom, author)
        conn
        |> render(:show, %{memo: %Memo{}})
      ["wildan", "wawaw_hunter"] ->
        author = Memos.get_author_by_name("Aeshma")
        memo_atom = for {key, val} <- memo, into: %{}, do: {String.to_atom(key), val}
        memo_rec = Memos.create_memo_author(memo_atom, author)
        conn
        |> render(:show, %{memo: %Memo{}})
      _ ->
        conn
        |> render(:show, %{memo: %Memo{}})
    end
  end
end
