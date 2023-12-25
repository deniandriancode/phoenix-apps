defmodule DiscordMemoWeb.MemoJSON do
  alias DiscordMemo.Memos.Memo

  @doc """
  Renders a list of memos.
  """
  def index(%{memos: memos}) do
    %{data: for(memo <- memos, do: data(memo))}
  end

  @doc """
  Renders a list of memos with author.
  """
  def index_author(%{memos: memos}) do
    %{data: for(memo <- memos, do: memo)}
  end

  @doc """
  Renders a single memo.
  """
  def show(%{memo: memo}) do
    %{data: data(memo)}
  end

  @doc """
  Renders a single memo with author.
  """
  def show_memo_author(%{memo: memo}) do
    %{data: memo}
  end

  defp data(%Memo{} = memo) do
    %{
      id: memo.id,
      title: memo.title,
      content: memo.content
    }
  end
end
