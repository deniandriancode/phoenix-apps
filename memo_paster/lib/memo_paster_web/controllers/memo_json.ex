defmodule MemoPasterWeb.MemoJSON do
  alias MemoPaster.Memos.Memo

  @doc """
  Renders a list of memos.
  """
  def index(%{memos: memos}) do
    %{data: for(memo <- memos, do: data(memo))}
  end

  @doc """
  Renders a single memo.
  """
  def show(%{memo: memo}) do
    %{data: data(memo)}
  end

  defp data(%Memo{} = memo) do
    %{
      id: memo.id,
      title: memo.title,
      content: memo.content
    }
  end
end
