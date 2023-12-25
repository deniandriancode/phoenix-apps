defmodule DiscordMemoWeb.AuthorControllerTest do
  use DiscordMemoWeb.ConnCase

  import DiscordMemo.MemosFixtures

  alias DiscordMemo.Memos.Author

  @create_attrs %{
    token: "some token",
    username: "some username"
  }
  @update_attrs %{
    token: "some updated token",
    username: "some updated username"
  }
  @invalid_attrs %{token: nil, username: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all authors", %{conn: conn} do
      conn = get(conn, ~p"/api/authors")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create author" do
    test "renders author when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/authors", author: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/authors/#{id}")

      assert %{
               "id" => ^id,
               "token" => "some token",
               "username" => "some username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/authors", author: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update author" do
    setup [:create_author]

    test "renders author when data is valid", %{conn: conn, author: %Author{id: id} = author} do
      conn = put(conn, ~p"/api/authors/#{author}", author: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/authors/#{id}")

      assert %{
               "id" => ^id,
               "token" => "some updated token",
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, author: author} do
      conn = put(conn, ~p"/api/authors/#{author}", author: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete author" do
    setup [:create_author]

    test "deletes chosen author", %{conn: conn, author: author} do
      conn = delete(conn, ~p"/api/authors/#{author}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/authors/#{author}")
      end
    end
  end

  defp create_author(_) do
    author = author_fixture()
    %{author: author}
  end
end
