defmodule FeedbackFormWeb.AdminHome do
  use Phoenix.LiveView
  alias FeedbackForm.Accounts

  def render(assigns) do
    ~H"""
    <%= if @current_user do %>
      <a href="/admins/feedbacks">Manage user feedbacks</a>
    <% else %>
      <p>You must login to manage user feedbacks</p>
    <% end %>
    """
  end

  def mount(_params, session, socket) do
    current_user = case session["admin_token"] do
      nil -> false
      _ -> Accounts.get_admin_by_session_token(session["admin_token"])
    end
    {:ok, assign(socket, [page_title: "Admin Home", current_user: current_user])}
  end
end
