defmodule MemoPaster.AuthorInit do
  alias MemoPaster.Repo
  alias MemoPaster.Memos.Author
  use GenServer

  def start_link(_options \\ []) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(_state) do
    Enum.map(["deniAndrian", "MarkSjaer", "Aeshma"], &create_author/1)
    :ignore
  end

  defp fetch_author(name) do
    Repo.get_by(Author, name: name)
  end

  defp create_author(name) do
    if fetch_author(name) == nil do
      attrs = %{name: name}
      %Author{}
      |> Author.changeset(attrs)
      |> Repo.insert()
    end
  end
end
# create initial authors, if authors already exist then skip
