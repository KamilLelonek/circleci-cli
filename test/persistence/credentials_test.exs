defmodule CircleciCli.Persistence.CredentialsTest do
  use ExUnit.Case

  import TestHelper

  require CircleciCli.Persistence.Token, as: Token

  @token "token"

  defp result, do: { @token, [], [] }

  setup do
    on_exit fn ->
      Token.clear
    end
  end

  test "should find a token in environmental variable" do
    System.put_env("CIRCLECI_API_TOKEN", @token)
    assert check_for_credentials([]) == result
  end

  test "should find a token in a file" do
    Token.write @token
    assert check_for_credentials([]) == result
  end

  test "should find a token in arguments" do
    assert check_for_credentials(["--token", @token])   == result
    assert check_for_credentials(["--token=#{@token}"]) == result
    assert check_for_credentials(["-t", @token])        == result
    assert check_for_credentials(["-t=#{@token}"])      == result
  end

  test "should shutdown when no token" do
    assert_capture_io [], &check_for_credentials/1
  end
end
