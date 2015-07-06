defmodule CircleciCli.Cli do
  require CircleciCli.Parser,                  as: Parser
  require CircleciCli.Interpreter,             as: Interpreter
  require CircleciCli.Persistence.Credentials, as: Credentials
  require CircleciCli.HTTP.Request,            as: Request
  require CircleciCli.HTTP.Builder,            as: Builder
  require CircleciCli.Persistence.Token,       as: Token

  def main(argv), do: argv |> Parser.parse |> dispatch

  defp dispatch({[token: token], ["configure"], _}), do: Token.write token

  defp dispatch({switches, command, _}) do
    {switches, command, []}
      |> Interpreter.check_for_help
      |> Credentials.check
      |> Interpreter.interpret
      |> Builder.build_request
      |> Request.send
      |> Request.process
  end
end
