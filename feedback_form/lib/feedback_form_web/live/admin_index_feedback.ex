defmodule FeedbackFormWeb.AdminIndexFeedback do
  use Phoenix.LiveView

  alias FeedbackForm.Records

  def render(assigns) do
  ~H"""
  <h1>Feedback List</h1>
  <section>
    <ul>
      <%= for feedback <- @feedbacks do %>
        <li>
          <p>Name: <%= feedback.name %></p>
          <p>Email: <%= feedback.email %></p>
          <p>Subject: <%= feedback.subject %></p>
          <p>Rating: <%= feedback.rating %></p>
          <p>Feedback: <%= feedback.feedback %></p>
          <a href={"/admins/feedbacks/#{feedback.id}/edit"}>Edit</a>
          <form action={"/admins/feedbacks/#{feedback.id}/delete"} method="get" onsubmit={"confirmDelete(event, #{feedback.id});"}>
            <button type="submit">Delete</button>
          </form>
        </li>
      <% end %>
    </ul>
  </section>
  <script>
  function confirmDelete(event, id) {
    event.preventDefault();
    continueDelete = window.confirm("Are you sure?")
    if (!continueDelete) return;

    event.target.submit();
  } 
  </script>
  """
  end

  def mount(_params, _session, socket) do
    feedbacks = Records.list_user_feedbacks()
    {:ok, assign(socket, [page_title: "Feedback List", feedbacks: feedbacks])}
  end
end
