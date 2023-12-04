defmodule MemoPaster.MemosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MemoPaster.Memos` context.
  """

  @doc """
  Generate a memo.
  """
  def memo_fixture(attrs \\ %{}) do
    {:ok, memo} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title"
      })
      |> MemoPaster.Memos.create_memo()

    memo
  end

  @doc """
  Generate a author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> MemoPaster.Memos.create_author()

    author
  end
end
