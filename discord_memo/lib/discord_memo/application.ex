defmodule DiscordMemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DiscordMemoWeb.Telemetry,
      DiscordMemo.Repo,
      {DNSCluster, query: Application.get_env(:discord_memo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DiscordMemo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DiscordMemo.Finch},
      # Start a worker by calling: DiscordMemo.Worker.start_link(arg)
      # {DiscordMemo.Worker, arg},
      # Start to serve requests, typically the last entry
      DiscordMemo.AuthorInit,
      DiscordMemoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DiscordMemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DiscordMemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
