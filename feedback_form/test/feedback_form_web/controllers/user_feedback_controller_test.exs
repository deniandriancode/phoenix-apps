defmodule FeedbackFormWeb.UserFeedbackControllerTest do
  use FeedbackFormWeb.ConnCase

  import FeedbackForm.RecordsFixtures

  @create_attrs %{email: "some email", feedback: "some feedback", name: "some name", rating: 120.5, subject: "some subject"}
  @update_attrs %{email: "some updated email", feedback: "some updated feedback", name: "some updated name", rating: 456.7, subject: "some updated subject"}
  @invalid_attrs %{email: nil, feedback: nil, name: nil, rating: nil, subject: nil}

  describe "index" do
    test "lists all user_feedbacks", %{conn: conn} do
      conn = get(conn, ~p"/user_feedbacks")
      assert html_response(conn, 200) =~ "Listing User feedbacks"
    end
  end

  describe "new user_feedback" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/user_feedbacks/new")
      assert html_response(conn, 200) =~ "New User feedback"
    end
  end

  describe "create user_feedback" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/user_feedbacks", user_feedback: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/user_feedbacks/#{id}"

      conn = get(conn, ~p"/user_feedbacks/#{id}")
      assert html_response(conn, 200) =~ "User feedback #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/user_feedbacks", user_feedback: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User feedback"
    end
  end

  describe "edit user_feedback" do
    setup [:create_user_feedback]

    test "renders form for editing chosen user_feedback", %{conn: conn, user_feedback: user_feedback} do
      conn = get(conn, ~p"/user_feedbacks/#{user_feedback}/edit")
      assert html_response(conn, 200) =~ "Edit User feedback"
    end
  end

  describe "update user_feedback" do
    setup [:create_user_feedback]

    test "redirects when data is valid", %{conn: conn, user_feedback: user_feedback} do
      conn = put(conn, ~p"/user_feedbacks/#{user_feedback}", user_feedback: @update_attrs)
      assert redirected_to(conn) == ~p"/user_feedbacks/#{user_feedback}"

      conn = get(conn, ~p"/user_feedbacks/#{user_feedback}")
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, user_feedback: user_feedback} do
      conn = put(conn, ~p"/user_feedbacks/#{user_feedback}", user_feedback: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User feedback"
    end
  end

  describe "delete user_feedback" do
    setup [:create_user_feedback]

    test "deletes chosen user_feedback", %{conn: conn, user_feedback: user_feedback} do
      conn = delete(conn, ~p"/user_feedbacks/#{user_feedback}")
      assert redirected_to(conn) == ~p"/user_feedbacks"

      assert_error_sent 404, fn ->
        get(conn, ~p"/user_feedbacks/#{user_feedback}")
      end
    end
  end

  defp create_user_feedback(_) do
    user_feedback = user_feedback_fixture()
    %{user_feedback: user_feedback}
  end
end
