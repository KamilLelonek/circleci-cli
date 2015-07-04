ExUnit.start

defmodule TestHelper do
  use ExUnit.Case

  import ExUnit.CaptureIO

  require CircleciCli.Parser,                  as: Parser
  require CircleciCli.Interpreter,             as: Interpreter
  require CircleciCli.Persistence.Credentials, as: Credentials

  def assert_build(args, result) do
    assert parse_and_interpret(args) == result
  end

  def parse_and_interpret(args) do
    args
      |> check_for_credentials
      |> Interpreter.interpret
  end

  def check_for_credentials(args) do
    args
      |> check_for_help
      |> Credentials.check
  end

  def check_for_help(args) do
    args
      |> Parser.parse
      |> Interpreter.check_for_help
  end

  def assert_capture_io_parse_and_interpret(args) do
    assert_capture_io args, &parse_and_interpret/1
  end

  def assert_capture_io(args, function ) do
    assert capture_io fn ->
      assert catch_exit(function.(args)) == :shutdown
    end
  end
end
