use Mix.Config

import_config "#{Mix.env}.exs"

config :circleci_cli,
       endpoint: "https://circleci.com/api/v1/",
       token:    System.get_env("CIRCLECI_TOKEN")
