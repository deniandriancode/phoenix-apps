defmodule DiscordMemo.MemosTest do
  use DiscordMemo.DataCase

  alias DiscordMemo.Memos

  describe "memos" do
    alias DiscordMemo.Memos.Memo

    import DiscordMemo.MemosFixtures

    @invalid_attrs %{title: nil, content: nil}

    test "list_memos/0 returns all memos" do
      memo = memo_fixture()
      assert Memos.list_memos() == [memo]
    end

    test "get_memo!/1 returns the memo with given id" do
      memo = memo_fixture()
      assert Memos.get_memo!(memo.id) == memo
    end

    test "create_memo/1 with valid data creates a memo" do
      valid_attrs = %{title: "some title", content: "some content"}

      assert {:ok, %Memo{} = memo} = Memos.create_memo(valid_attrs)
      assert memo.title == "some title"
      assert memo.content == "some content"
    end

    test "create_memo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Memos.create_memo(@invalid_attrs)
    end

    test "update_memo/2 with valid data updates the memo" do
      memo = memo_fixture()
      update_attrs = %{title: "some updated title", content: "some updated content"}

      assert {:ok, %Memo{} = memo} = Memos.update_memo(memo, update_attrs)
      assert memo.title == "some updated title"
      assert memo.content == "some updated content"
    end

    test "update_memo/2 with invalid data returns error changeset" do
      memo = memo_fixture()
      assert {:error, %Ecto.Changeset{}} = Memos.update_memo(memo, @invalid_attrs)
      assert memo == Memos.get_memo!(memo.id)
    end

    test "delete_memo/1 deletes the memo" do
      memo = memo_fixture()
      assert {:ok, %Memo{}} = Memos.delete_memo(memo)
      assert_raise Ecto.NoResultsError, fn -> Memos.get_memo!(memo.id) end
    end

    test "change_memo/1 returns a memo changeset" do
      memo = memo_fixture()
      assert %Ecto.Changeset{} = Memos.change_memo(memo)
    end
  end

  describe "authors" do
    alias DiscordMemo.Memos.Author

    import DiscordMemo.MemosFixtures

    @invalid_attrs %{token: nil, username: nil}

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Memos.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Memos.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      valid_attrs = %{token: "some token", username: "some username"}

      assert {:ok, %Author{} = author} = Memos.create_author(valid_attrs)
      assert author.token == "some token"
      assert author.username == "some username"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Memos.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      update_attrs = %{token: "some updated token", username: "some updated username"}

      assert {:ok, %Author{} = author} = Memos.update_author(author, update_attrs)
      assert author.token == "some updated token"
      assert author.username == "some updated username"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Memos.update_author(author, @invalid_attrs)
      assert author == Memos.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Memos.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Memos.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Memos.change_author(author)
    end
  end
end
