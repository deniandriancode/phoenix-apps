defmodule MemoPasterWeb.MemoHTML do
  use MemoPasterWeb, :html

  embed_templates "memo_html/*"

  @doc """
  Renders a memo form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def memo_form(assigns)
end
