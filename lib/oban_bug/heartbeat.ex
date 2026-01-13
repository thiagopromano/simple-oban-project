defmodule ObanBug.HeartbeatWorker do
  use Oban.Pro.Worker, queue: :default, max_attempts: 1
  require Logger

  @impl Oban.Pro.Worker
  def process(_job) do
    node = Node.self()
    timestamp = DateTime.utc_now() |> DateTime.to_string()
    Logger.info("Heartbeat: node=#{node} timestamp=#{timestamp}")
  end
end
