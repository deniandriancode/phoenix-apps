defmodule FeedbackFormWeb.AdminFeedbackController do
  use FeedbackFormWeb, :controller

  alias FeedbackForm.Records
  require HTTPoison

  def update(conn, %{"user_feedback" => user_feedback, "id" => id}) do
    Records.get_user_feedback!(id)
    |> Records.update_user_feedback(user_feedback)
    redirect(conn, to: ~p"/admins/feedbacks")
  end

  def delete_request(conn, %{"id" => id}) do
    # url = FeedbackFormWeb.Endpoint.url()
    # HTTPoison.delete!("#{url}/admins/feedbacks/#{id}/delete")
    delete(id)
    redirect(conn, to: ~p"/admins/feedbacks")
  end

  defp delete(id) do
    Records.get_user_feedback!(id)
    |> Records.delete_user_feedback()
  end
end
