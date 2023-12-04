defmodule MemoPasterWeb.MemoControllerTest do
  use MemoPasterWeb.ConnCase

  import MemoPaster.MemosFixtures

  @create_attrs %{title: "some title", content: "some content"}
  @update_attrs %{title: "some updated title", content: "some updated content"}
  @invalid_attrs %{title: nil, content: nil}

  describe "index" do
    test "lists all memos", %{conn: conn} do
      conn = get(conn, ~p"/memos")
      assert html_response(conn, 200) =~ "Listing Memos"
    end
  end

  describe "new memo" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/memos/new")
      assert html_response(conn, 200) =~ "New Memo"
    end
  end

  describe "create memo" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/memos", memo: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/memos/#{id}"

      conn = get(conn, ~p"/memos/#{id}")
      assert html_response(conn, 200) =~ "Memo #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/memos", memo: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Memo"
    end
  end

  describe "edit memo" do
    setup [:create_memo]

    test "renders form for editing chosen memo", %{conn: conn, memo: memo} do
      conn = get(conn, ~p"/memos/#{memo}/edit")
      assert html_response(conn, 200) =~ "Edit Memo"
    end
  end

  describe "update memo" do
    setup [:create_memo]

    test "redirects when data is valid", %{conn: conn, memo: memo} do
      conn = put(conn, ~p"/memos/#{memo}", memo: @update_attrs)
      assert redirected_to(conn) == ~p"/memos/#{memo}"

      conn = get(conn, ~p"/memos/#{memo}")
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, memo: memo} do
      conn = put(conn, ~p"/memos/#{memo}", memo: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Memo"
    end
  end

  describe "delete memo" do
    setup [:create_memo]

    test "deletes chosen memo", %{conn: conn, memo: memo} do
      conn = delete(conn, ~p"/memos/#{memo}")
      assert redirected_to(conn) == ~p"/memos"

      assert_error_sent 404, fn ->
        get(conn, ~p"/memos/#{memo}")
      end
    end
  end

  defp create_memo(_) do
    memo = memo_fixture()
    %{memo: memo}
  end
end
