defmodule CircleciCli.Cli do
  require CircleciCli.Parser,                  as: Parser
  require CircleciCli.Interpreter,             as: Interpreter
  require CircleciCli.Persistence.Credentials, as: Credentials
  require CircleciCli.HTTP.Request,            as: Request
  require CircleciCli.HTTP.Builder,            as: Builder

  def main(argv) do
    argv
      |> Parser.parse
      |> Interpreter.check_for_help
      |> Credentials.check
      |> Interpreter.interpret
      |> Builder.build_request
      |> Request.send
  end
end
