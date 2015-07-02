defmodule CircleciCli.Persistence.Credentials do
  require CircleciCli.Persistence.Token, as: Token

  def check(args) do
    case parsed_args(args) do
      { [token: token], _, _ } when byte_size(token) > 0 -> token
      _ -> fetch_token Token.read
    end
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
      CircleCI API token is not set!

      You can create one here: https://circleci.com/account/api and then do one of the following:

        1. Set CIRCLECI_API_TOKEN environment variable so that CircleCI CLI will be able to fetch it.
        2. Run `circleci_cli configure --token=YOUR_CIRCLECI_API_TOKEN` to save the token.
        3. Append `--token=YOUR_CIRCLECI_API_TOKEN` flag to each of `circleci_cli` command.
    """
    exit :shutdown
  end

  defp fetch_token({:ok, token}), do: token
end
