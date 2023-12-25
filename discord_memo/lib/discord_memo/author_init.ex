defmodule DiscordMemo.AuthorInit do
  @discord_users [
    %{username: "MarkSkjær", token: "794166754850504724"},
    %{username: "Aeshma", token: "433647403690622986"},
    %{username: "__andrian_deni", token: "871707742312726590"}
  ]

  alias DiscordMemo.Repo
  alias DiscordMemo.Memos.Author
  use GenServer

  def start_link(_options \\ []) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(_state) do
    Enum.map(@discord_users, &create_author/1)
    :ignore
  end

  defp fetch_author(token) do
    Repo.get_by(Author, token: token)
  end

  defp create_author(%{username: username, token: token}) do
    if fetch_author(token) == nil do
      attrs = %{username: username, token: token}
      %Author{}
      |> Author.changeset(attrs)
      |> Repo.insert
    end
  end
end
