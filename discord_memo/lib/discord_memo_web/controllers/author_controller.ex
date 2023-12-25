defmodule DiscordMemoWeb.AuthorController do
  use DiscordMemoWeb, :controller

  alias DiscordMemo.Memos
  alias DiscordMemo.Memos.Author

  action_fallback DiscordMemoWeb.FallbackController

  def index(conn, _params) do
    authors = Memos.list_authors()
    render(conn, :index, authors: authors)
  end

  def create(conn, %{"author" => author_params}) do
    with {:ok, %Author{} = author} <- Memos.create_author(author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/discord/api/authors/#{author}")
      |> render(:show, author: author)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Memos.get_author!(id)
    render(conn, :show, author: author)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = Memos.get_author!(id)

    with {:ok, %Author{} = author} <- Memos.update_author(author, author_params) do
      render(conn, :show, author: author)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Memos.get_author!(id)

    with {:ok, %Author{}} <- Memos.delete_author(author) do
      send_resp(conn, :no_content, "")
    end
  end
end
