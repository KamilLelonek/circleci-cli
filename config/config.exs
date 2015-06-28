use Mix.Config

config :circleci_cli,
       endpoint: "https://circleci.com/api/v1/",
       token:    System.get_env("CIRCLECI_TOKEN")

config :logger, compile_time_purge_level: :debug

import_config "#{Mix.env}.exs"
