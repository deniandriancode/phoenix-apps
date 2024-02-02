defmodule FeedbackForm.RecordsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FeedbackForm.Records` context.
  """

  @doc """
  Generate a user_feedback.
  """
  def user_feedback_fixture(attrs \\ %{}) do
    {:ok, user_feedback} =
      attrs
      |> Enum.into(%{
        email: "some email",
        feedback: "some feedback",
        name: "some name",
        rating: 120.5,
        subject: "some subject"
      })
      |> FeedbackForm.Records.create_user_feedback()

    user_feedback
  end
end
