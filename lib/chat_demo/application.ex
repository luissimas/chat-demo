defmodule ChatDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ChatDemoWeb.Telemetry,
      # Start the Ecto repository
      ChatDemo.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ChatDemo.PubSub},
      # Start Finch
      {Finch, name: ChatDemo.Finch},
      # Start the Presence system
      ChatDemoWeb.RoomPresence,
      # Start the Endpoint (http/https)
      ChatDemoWeb.Endpoint
      # Start a worker by calling: ChatDemo.Worker.start_link(arg)
      # {ChatDemo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChatDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChatDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
