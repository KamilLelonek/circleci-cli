defmodule CircleciCli.Cli do
  require CircleciCli.Parser,                  as: Parser
  require CircleciCli.Interpreter,             as: Interpreter
  require CircleciCli.Persistence.Credentials, as: Credentials
  require CircleciCli.HTTP.Request,            as: Request

  def main(argv) do
    argv
      |> Parser.parse
      |> Interpreter.check_for_help
      |> Credentials.check
      |> Interpreter.interpret_command
      |> Request.send
  end
end
