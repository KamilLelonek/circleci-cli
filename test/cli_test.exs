defmodule CircleciCli.CliTest do
  use ExUnit.Case

  import CircleciCli.Cli

  test ":help returned by option parsing with -h and --help options" do
    assert run(["-h",     "anything"]) == :help
    assert run(["--help", "anything"]) == :help
  end

  test ":help returned by option parsing when token flag provided without token value" do
    assert run(["user", "--token"]) == :help
  end
end
