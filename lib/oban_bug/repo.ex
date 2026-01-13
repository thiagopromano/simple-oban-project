defmodule ObanBug.Repo do
  use Ecto.Repo,
    otp_app: :oban_bug,
    adapter: Ecto.Adapters.Postgres
end
