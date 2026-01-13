import Config

config :oban_bug, ObanBug.Repo,
      hostname: "localhost",
      database: "oban_bug",
      username: "postgres",
      password: "postgres",
      queue_target: 5_000


config :oban_bug,
  ecto_repos: [ObanBug.Repo]
