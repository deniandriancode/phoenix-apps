defmodule FeedbackForm.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FeedbackFormWeb.Telemetry,
      FeedbackForm.Repo,
      {DNSCluster, query: Application.get_env(:feedback_form, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FeedbackForm.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FeedbackForm.Finch},
      # Start a worker by calling: FeedbackForm.Worker.start_link(arg)
      # {FeedbackForm.Worker, arg},
      # Start to serve requests, typically the last entry
      FeedbackFormWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FeedbackForm.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FeedbackFormWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
