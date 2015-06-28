defmodule CircleciCli.Cli do
  require CircleciCli.Parser
  alias   CircleciCli.Parser
  require CircleciCli.Interpreter
  alias   CircleciCli.Interpreter

  def main(argv) do
    argv
      |> Parser.parse_args
      |> Interpreter.interpret_command
  end
end
