defmodule Kontact.ContactFront do

  import Ecto.Changeset
  import Ecto.Query
  alias Kontact.Contact
  alias Kontact.Repo

  def register_changeset(params \\ %{}) do
    %Contact{}
    |> cast(params, [:name, :email, :phone])
    |> validate_required([:name, :email, :phone])
  end

  def add(%{"name" => name, "email" => email, "phone" => phone}) do
    struct(Contact, %{name: name, email: email, phone: phone})
    |> Repo.insert
  end

  def all_contacts() do
    query = from c in Contact,
            select: c
    Repo.all query
  end

  def find(id) do
    Repo.get(Contact, id)
    |> Map.from_struct
    |> register_changeset
  end

  def update(contact, id) do
    Repo.get!(Contact, id)
    |> Ecto.Changeset.change(contact)
    |> Repo.update
  end

  def delete(id) do
    Repo.get!(Contact, id)
    |> Repo.delete
  end

end
