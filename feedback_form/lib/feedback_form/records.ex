defmodule FeedbackForm.Records do
  @moduledoc """
  The Records context.
  """

  import Ecto.Query, warn: false
  alias FeedbackForm.Repo

  alias FeedbackForm.Records.UserFeedback

  @doc """
  Returns the list of user_feedbacks.

  ## Examples

      iex> list_user_feedbacks()
      [%UserFeedback{}, ...]

  """
  def list_user_feedbacks do
    Repo.all(UserFeedback)
  end

  @doc """
  Gets a single user_feedback.

  Raises `Ecto.NoResultsError` if the User feedback does not exist.

  ## Examples

      iex> get_user_feedback!(123)
      %UserFeedback{}

      iex> get_user_feedback!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_feedback!(id), do: Repo.get!(UserFeedback, id)

  @doc """
  Creates a user_feedback.

  ## Examples

      iex> create_user_feedback(%{field: value})
      {:ok, %UserFeedback{}}

      iex> create_user_feedback(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_feedback(attrs \\ %{}) do
    %UserFeedback{}
    |> UserFeedback.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_feedback.

  ## Examples

      iex> update_user_feedback(user_feedback, %{field: new_value})
      {:ok, %UserFeedback{}}

      iex> update_user_feedback(user_feedback, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_feedback(%UserFeedback{} = user_feedback, attrs) do
    user_feedback
    |> UserFeedback.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_feedback.

  ## Examples

      iex> delete_user_feedback(user_feedback)
      {:ok, %UserFeedback{}}

      iex> delete_user_feedback(user_feedback)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_feedback(%UserFeedback{} = user_feedback) do
    Repo.delete(user_feedback)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_feedback changes.

  ## Examples

      iex> change_user_feedback(user_feedback)
      %Ecto.Changeset{data: %UserFeedback{}}

  """
  def change_user_feedback(%UserFeedback{} = user_feedback, attrs \\ %{}) do
    UserFeedback.changeset(user_feedback, attrs)
  end
end
