defmodule ObanBug.Application do
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    topologies = [local: [strategy: Cluster.Strategy.LocalEpmd]]

    children = [
      {Cluster.Supervisor, [topologies, [name: SignalInsights.ClusterSupervisor]]},
      ObanBug.Repo,
      {Oban, oban_config()}
    ]

    Logger.info("Starting application...")
    Oban.Telemetry.attach_default_logger()

    opts = [strategy: :one_for_one, name: ObanBug.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp oban_config do
    web? =
      Node.self()
      |> Atom.to_string()
      |> String.starts_with?("web")

    [
      engine: Oban.Pro.Engines.Smart,
      notifier: Oban.Notifiers.PG,
      peer: if(web?, do: false, else: Oban.Peers.Global),
      queues: if(web?, do: [], else: [default: 10]),
      repo: ObanBug.Repo,
      plugins:
        if(web?,
          do: [],
          else: [
            {
              Oban.Pro.Plugins.DynamicCron,
              guaranteed: true,
              sync_mode: :automatic,
              crontab: [
                {"* * * * *", ObanBug.HeartbeatWorker}
              ]
            }
          ]
        )
    ]
  end
end
