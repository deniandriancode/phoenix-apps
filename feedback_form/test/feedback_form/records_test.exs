defmodule FeedbackForm.RecordsTest do
  use FeedbackForm.DataCase

  alias FeedbackForm.Records

  describe "user_feedbacks" do
    alias FeedbackForm.Records.UserFeedback

    import FeedbackForm.RecordsFixtures

    @invalid_attrs %{email: nil, feedback: nil, name: nil, rating: nil, subject: nil}

    test "list_user_feedbacks/0 returns all user_feedbacks" do
      user_feedback = user_feedback_fixture()
      assert Records.list_user_feedbacks() == [user_feedback]
    end

    test "get_user_feedback!/1 returns the user_feedback with given id" do
      user_feedback = user_feedback_fixture()
      assert Records.get_user_feedback!(user_feedback.id) == user_feedback
    end

    test "create_user_feedback/1 with valid data creates a user_feedback" do
      valid_attrs = %{email: "some email", feedback: "some feedback", name: "some name", rating: 120.5, subject: "some subject"}

      assert {:ok, %UserFeedback{} = user_feedback} = Records.create_user_feedback(valid_attrs)
      assert user_feedback.email == "some email"
      assert user_feedback.feedback == "some feedback"
      assert user_feedback.name == "some name"
      assert user_feedback.rating == 120.5
      assert user_feedback.subject == "some subject"
    end

    test "create_user_feedback/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Records.create_user_feedback(@invalid_attrs)
    end

    test "update_user_feedback/2 with valid data updates the user_feedback" do
      user_feedback = user_feedback_fixture()
      update_attrs = %{email: "some updated email", feedback: "some updated feedback", name: "some updated name", rating: 456.7, subject: "some updated subject"}

      assert {:ok, %UserFeedback{} = user_feedback} = Records.update_user_feedback(user_feedback, update_attrs)
      assert user_feedback.email == "some updated email"
      assert user_feedback.feedback == "some updated feedback"
      assert user_feedback.name == "some updated name"
      assert user_feedback.rating == 456.7
      assert user_feedback.subject == "some updated subject"
    end

    test "update_user_feedback/2 with invalid data returns error changeset" do
      user_feedback = user_feedback_fixture()
      assert {:error, %Ecto.Changeset{}} = Records.update_user_feedback(user_feedback, @invalid_attrs)
      assert user_feedback == Records.get_user_feedback!(user_feedback.id)
    end

    test "delete_user_feedback/1 deletes the user_feedback" do
      user_feedback = user_feedback_fixture()
      assert {:ok, %UserFeedback{}} = Records.delete_user_feedback(user_feedback)
      assert_raise Ecto.NoResultsError, fn -> Records.get_user_feedback!(user_feedback.id) end
    end

    test "change_user_feedback/1 returns a user_feedback changeset" do
      user_feedback = user_feedback_fixture()
      assert %Ecto.Changeset{} = Records.change_user_feedback(user_feedback)
    end
  end
end
