defmodule FeedbackFormWeb.UserFeedbackHTML do
  use FeedbackFormWeb, :html

  embed_templates "user_feedback_html/*"

  @doc """
  Renders a user_feedback form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def user_feedback_form(assigns)
end
