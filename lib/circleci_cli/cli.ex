defmodule CircleciCli.Cli do
  require CircleciCli.Parser,      as: Parser
  require CircleciCli.Interpreter, as: Interpreter

  def main(argv) do
    argv
      |> Parser.parse_args
      |> Interpreter.interpret_command
  end
end
