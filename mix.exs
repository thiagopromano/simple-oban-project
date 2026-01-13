defmodule ObanBug.MixProject do
  use Mix.Project

  def project do
    [
      app: :oban_bug,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ObanBug.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.13"},
      {:postgrex, "~> 0.22"},
      {:libcluster, "~> 3.3"},
      {:oban, "== 2.20.1"},
      {:oban_pro, "== 1.6.7", repo: "oban"}
    ]
  end
end
