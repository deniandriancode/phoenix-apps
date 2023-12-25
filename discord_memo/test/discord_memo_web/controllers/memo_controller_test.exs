defmodule DiscordMemoWeb.MemoControllerTest do
  use DiscordMemoWeb.ConnCase

  import DiscordMemo.MemosFixtures

  alias DiscordMemo.Memos.Memo

  @create_attrs %{
    title: "some title",
    content: "some content"
  }
  @update_attrs %{
    title: "some updated title",
    content: "some updated content"
  }
  @invalid_attrs %{title: nil, content: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all memos", %{conn: conn} do
      conn = get(conn, ~p"/api/memos")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create memo" do
    test "renders memo when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/memos", memo: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/memos/#{id}")

      assert %{
               "id" => ^id,
               "content" => "some content",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/memos", memo: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update memo" do
    setup [:create_memo]

    test "renders memo when data is valid", %{conn: conn, memo: %Memo{id: id} = memo} do
      conn = put(conn, ~p"/api/memos/#{memo}", memo: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/memos/#{id}")

      assert %{
               "id" => ^id,
               "content" => "some updated content",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, memo: memo} do
      conn = put(conn, ~p"/api/memos/#{memo}", memo: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete memo" do
    setup [:create_memo]

    test "deletes chosen memo", %{conn: conn, memo: memo} do
      conn = delete(conn, ~p"/api/memos/#{memo}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/memos/#{memo}")
      end
    end
  end

  defp create_memo(_) do
    memo = memo_fixture()
    %{memo: memo}
  end
end
