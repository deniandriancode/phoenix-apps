defmodule FeedbackFormWeb.UserFeedbackController do
  use FeedbackFormWeb, :controller

  alias FeedbackForm.Records
  alias FeedbackForm.Records.UserFeedback

  def index(conn, _params) do
    user_feedbacks = Records.list_user_feedbacks()
    render(conn, :index, user_feedbacks: user_feedbacks)
  end

  def new(conn, _params) do
    changeset = Records.change_user_feedback(%UserFeedback{})
    render(conn, :new, [changeset: changeset, page_title: "New Feedback"])
  end

  def create(conn, %{"user_feedback" => user_feedback_params}) do
    case Records.create_user_feedback(user_feedback_params) do
      {:ok, _user_feedback} ->
        conn
        |> put_flash(:info, "User feedback created successfully.")
        |> redirect(to: ~p"/user_feedbacks/thankyou")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_feedback = Records.get_user_feedback!(id)
    render(conn, :show, user_feedback: user_feedback)
  end

  def edit(conn, %{"id" => id}) do
    user_feedback = Records.get_user_feedback!(id)
    changeset = Records.change_user_feedback(user_feedback)
    render(conn, :edit, user_feedback: user_feedback, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_feedback" => user_feedback_params}) do
    user_feedback = Records.get_user_feedback!(id)

    case Records.update_user_feedback(user_feedback, user_feedback_params) do
      {:ok, user_feedback} ->
        conn
        |> put_flash(:info, "User feedback updated successfully.")
        |> redirect(to: ~p"/user_feedbacks/#{user_feedback}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, user_feedback: user_feedback, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_feedback = Records.get_user_feedback!(id)
    {:ok, _user_feedback} = Records.delete_user_feedback(user_feedback)

    conn
    |> put_flash(:info, "User feedback deleted successfully.")
    |> redirect(to: ~p"/user_feedbacks")
  end

  # user defined controllers
  def thankyou(conn, _params) do
    render(conn, :thankyou)
  end
end
