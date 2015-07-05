defmodule CircleciCli.Mixfile do
  use Mix.Project

  def project do
    [
      app:             :circleci_cli,
      source_url:      "https://github.com/KamilLelonek/circleci-cli",
      version:         "0.0.1",
      elixir:          "~> 1.0",
      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps:            deps,
      escript:         escript_config
    ]
  end

  def application do
    [
      applications: [
        :logger,
        :httpoison
      ]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.7"},
      {:exjsx,     "~> 3.1.0"}
    ]
  end

  defp escript_config do
    [main_module: CircleciCli.Cli]
  end
end
