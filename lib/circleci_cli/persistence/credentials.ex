defmodule CircleciCli.Persistence.Credentials do
  require CircleciCli.Persistence.Token, as: Token

  def check({switches, command, _}) do
    case separate_token(switches) do
      {token, switches} -> {extract_token(token), command, switches}
    end
  end

  defp separate_token(switches), do: switches |> Keyword.pop(:token, "")

  defp extract_token(""),           do: extract_token(Token.read)
  defp extract_token({:ok, token}), do: token
  defp extract_token({:error, _})   do
    IO.puts """
      CircleCI API token is not set! Neither file nor environmental variable with token was found.

      You can create one here: https://circleci.com/account/api and then do one of the following:

        1. Set CIRCLECI_API_TOKEN environment variable so that CircleCI CLI will be able to fetch it.
        2. Run `circleci_cli configure --token=YOUR_CIRCLECI_API_TOKEN` to save the token.
        3. Append `--token=YOUR_CIRCLECI_API_TOKEN` flag to each of `circleci_cli` command.
    """
    exit :shutdown
  end

  defp extract_token(token), do: token
end
