defmodule CircleciCli.Persistence.CredentialsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  require CircleciCli.Persistence.Credentials, as: Credentials
  require CircleciCli.Persistence.Token,       as: Token
  require CircleciCli.Parser,                  as: Parser
  require CircleciCli.Interpreter,             as: Interpreter

  @token "token"

  defp result, do: { "token", [], [] }

  setup do
    on_exit fn ->
      Token.clear
    end
  end

  test "should find a token in environmental variable" do
    System.put_env("CIRCLECI_API_TOKEN", @token)
    assert check([]) == result
  end

  test "should find a token in a file" do
    Token.write @token
    assert check([]) == result
  end

  test "should find a token in arguments" do
    assert check(["--token", @token])   == result
    assert check(["--token=#{@token}"]) == result
    assert check(["-t", @token])        == result
    assert check(["-t=#{@token}"])      == result
  end

  test "should shutdown when no token" do
    assert capture_io fn ->
      assert catch_exit(check([])) == :shutdown
    end
  end

  defp check(arguments) do
    arguments
      |> Parser.parse
      |> Interpreter.check_for_help
      |> Credentials.check
  end
end
