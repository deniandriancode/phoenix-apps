defmodule Kontact.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KontactWeb.Telemetry,
      Kontact.Repo,
      {DNSCluster, query: Application.get_env(:kontact, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Kontact.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Kontact.Finch},
      # Start a worker by calling: Kontact.Worker.start_link(arg)
      # {Kontact.Worker, arg},
      # Start to serve requests, typically the last entry
      KontactWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kontact.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KontactWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
