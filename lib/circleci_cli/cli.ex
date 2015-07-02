defmodule CircleciCli.Cli do
  require CircleciCli.Parser,                  as: Parser
  require CircleciCli.Interpreter,             as: Interpreter
  require CircleciCli.Persistence.Credentials, as: Credentials

  def main(argv) do
    argv
      |> Credentials.check
      |> Parser.parse_args(argv)
      |> Interpreter.interpret_command
  end
end
