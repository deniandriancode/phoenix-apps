defmodule FeedbackFormWeb.AdminEditFeedback do
  use FeedbackFormWeb, :live_view

  alias FeedbackForm.Records

  def render(assigns) do
  ~H"""
  <h1>Feedback Edit</h1>
  <section>
    <.form
      for={@feedback}
      id="feedback_edit"
      action={~p"/admins/feedbacks/#{@feedback.data.id}/edit"}
      phx-method="put"
    >
      <.input field={@feedback[:name]} value={@feedback.data.name} required={true} />
      <.input field={@feedback[:subject]} value={@feedback.data.subject} required={true} />
      <.input field={@feedback[:email]} value={@feedback.data.email} type={"email"} required={true} />
      <.input field={@feedback[:rating]} value={@feedback.data.rating} type={"number"} step="0.01" min="0.0" max="10.0" required={true} />
      <.input field={@feedback[:feedback]} value={@feedback.data.feedback} type={"textarea"} required={true} />
      <button>Update</button>
    </.form>
  </section>
  <div>
    <form action={"/admins/feedbacks/#{@feedback.data.id}/delete"} method="get">
      <button type="submit">Delete</button>
    </form>
  </div>
  """
  end

  def mount(%{"id" => id}, _session, socket) do
    feedback = Records.get_user_feedback!(id) |> Ecto.Changeset.change |> to_form
    {:ok, assign(socket, [page_title: "Feedback Edit", feedback: feedback])}
  end
end
