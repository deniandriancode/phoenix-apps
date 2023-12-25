defmodule DiscordMemo.MemosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiscordMemo.Memos` context.
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
      |> DiscordMemo.Memos.create_memo()

    memo
  end

  @doc """
  Generate a author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        token: "some token",
        username: "some username"
      })
      |> DiscordMemo.Memos.create_author()

    author
  end
end
