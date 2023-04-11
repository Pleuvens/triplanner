defmodule Triplanner.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TriplannerWeb.Telemetry,
      # Start the Ecto repository
      Triplanner.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Triplanner.PubSub},
      # Start Finch
      {Finch, name: Triplanner.Finch},
      # Start the Endpoint (http/https)
      TriplannerWeb.Endpoint
      # Start a worker by calling: Triplanner.Worker.start_link(arg)
      # {Triplanner.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Triplanner.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TriplannerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
