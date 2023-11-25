defmodule KontactWeb.PageController do
  use KontactWeb, :controller
  alias Kontact.ContactFront

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    conn
    # |> put_root_layout(false)
    |> render(:home)
  end

  def new(conn, _params) do
    changeset = ContactFront.register_changeset
    render conn, contact_changeset: changeset
  end

  def edit(conn, %{"id" => id}) do
    contact_found = ContactFront.find id
    render conn, contact: contact_found, id: id
  end

  def delete(conn, %{"id" => id}) do
    ContactFront.delete id
    redirect(conn, to: ~p"/kontacts")
  end

  def kontacts(conn, _params) do
    contacts = ContactFront.all_contacts
    render conn, contacts: contacts
  end

  def create_contact(conn, %{"contact" => contact}) do
    ContactFront.add contact
    redirect(conn, to: ~p"/kontacts")
  end

  def update_contact(conn, %{"id" => id, "contact" => contact}) do
    contact_atom = for {key, value} <- contact, into: %{} do 
      {String.to_atom(key), value}
    end
    ContactFront.update contact_atom, id
    redirect(conn, to: ~p"/kontacts")
  end
end
