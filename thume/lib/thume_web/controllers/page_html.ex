defmodule ThumeWeb.PageHTML do
  use ThumeWeb, :html

  embed_templates "page_html/*"

  def blank_page(assigns) do
    ~H"""
    <p>Blank Page</p>
    """
  end
end
