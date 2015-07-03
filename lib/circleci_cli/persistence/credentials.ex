defmodule CircleciCli.Persistence.Credentials do
  require CircleciCli.Persistence.Token, as: Token

  def check(args) do
    case token_from_args(args) do
      token when token != nil and token != "" -> token
      _ -> fetch_token Token.read
    end
  end

  defp token_from_args(args) do
    parsed_args(args)|> elem(0) |> Keyword.get(:token)
  end

  defp parsed_args(args) do
    OptionParser.parse(
      args,
      switches: [token: :string],
      aliases:  [t:     :token]
    )
  end

  defp fetch_token({:error, _}) do
    IO.puts """
      CircleCI API token is not set! Neither file nor environmental variable with token was found.

      You can create one here: https://circleci.com/account/api and then do one of the following:

        1. Set CIRCLECI_API_TOKEN environment variable so that CircleCI CLI will be able to fetch it.
        2. Run `circleci_cli configure --token=YOUR_CIRCLECI_API_TOKEN` to save the token.
        3. Append `--token=YOUR_CIRCLECI_API_TOKEN` flag to each of `circleci_cli` command.
    """
    exit :shutdown
  end

  defp fetch_token({:ok, token}), do: token
end
