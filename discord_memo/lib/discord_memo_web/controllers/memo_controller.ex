# add meaningful messages on each route
defmodule DiscordMemoWeb.MemoController do
  use DiscordMemoWeb, :controller

  alias DiscordMemo.Repo
  alias DiscordMemo.Memos
  alias DiscordMemo.Memos.{Memo, Author}

  import Ecto.Query

  action_fallback DiscordMemoWeb.FallbackController

  def index(conn, _params) do
    memos = Memos.list_memos()
    render(conn, :index_author, memos: memos)
  end

  # def create(conn, %{"memo" => memo_params}) do
  #   with {:ok, %Memo{} = memo} <- Memos.create_memo(memo_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", ~p"/discord/api/memos/#{memo}")
  #     |> render(:show, memo: memo)
  #   end
  # end

  def create(conn, %{"memo" => memo_params}) do
    with {:ok, %Memo{} = memo} <- Memos.create_memo(memo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/discord/api/memos/#{memo}")
      |> render(:show, memo: memo)
    end
  end

  def show(conn, %{"id" => id}) do
    memo = Memos.get_memo!(id)
    author = Memos.get_author!(memo.author_id)
    memo_data = %{
      id: memo.id,
      title: memo.title,
      content: memo.content,
      author: %{
        id: memo.author_id,
        username: author.username,
        token: author.token
      }
    }
    render(conn, :show_memo_author, memo: memo_data)
  end

  def update(conn, %{"id" => id, "memo" => memo_params}) do
    memo = Memos.get_memo!(id)

    with {:ok, %Memo{} = memo} <- Memos.update_memo(memo, memo_params) do
      render(conn, :show, memo: memo)
    end
  end

  def delete(conn, %{"id" => id}) do
    memo = Memos.get_memo!(id)

    case Memos.delete_memo(memo, conn) do
      {:ok, %Memo{}} ->
        send_resp(conn, :no_content, "")
      {:error, %Memo{}} -> send_resp(conn, :accepted, "You are not authorized")
    end
  end

  def random_memo(conn, _params) do
    n_min = 1
    n_max = Memos.count_memo
    rnd = Enum.random n_min..n_max
    memo = Memos.get_memo!(rnd)
    author = Memos.get_author!(memo.author_id)
    memo_data = %{
      id: memo.id,
      title: memo.title,
      content: memo.content,
      author: %{
        id: memo.author_id,
        username: author.username,
        token: author.token
      }
    }
    render(conn, :show_memo_author, memo: memo_data)
  end
end
