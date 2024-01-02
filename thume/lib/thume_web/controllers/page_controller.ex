defmodule ThumeWeb.PageController do
  use ThumeWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def chat(conn, %{"username" => username}) do
    render(conn, :chat, [layout: false, username: username])
  end

  def chat(conn, _params) do
    render(conn, :blank_page, layout: false)
  end
end
