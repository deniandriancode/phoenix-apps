defmodule MemoPaster.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MemoPasterWeb.Telemetry,
      MemoPaster.Repo,
      {DNSCluster, query: Application.get_env(:memo_paster, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MemoPaster.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MemoPaster.Finch},
      # New worker
      MemoPaster.AuthorInit,
      # Start a worker by calling: MemoPaster.Worker.start_link(arg)
      # {MemoPaster.Worker, arg},
      # Start to serve requests, typically the last entry
      MemoPasterWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MemoPaster.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MemoPasterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
