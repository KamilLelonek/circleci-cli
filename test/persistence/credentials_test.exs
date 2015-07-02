defmodule CircleciCli.Persistence.CredentialsTest do
  use ExUnit.Case

  require CircleciCli.Persistence.Credentials, as: Credentials
  require CircleciCli.Persistence.Token,       as: Token

  @token "token"

  setup do
    on_exit fn ->
      Token.clear
    end
  end

  test "should find a token in environmental variable" do
    System.put_env("CIRCLECI_API_TOKEN", @token)
    assert Credentials.check([]) == @token
  end

  test "should find a token in a file" do
    Token.write @token
    assert Credentials.check([]) == @token
  end

  test "should find a token in arguments" do
    assert Credentials.check(["--token", @token])   == @token
    assert Credentials.check(["--token=#{@token}"]) == @token
    assert Credentials.check(["-t", @token])        == @token
    assert Credentials.check(["-t=#{@token}"])      == @token
  end

  test "should shutdown when no token" do
    assert catch_exit(Credentials.check([])) == :shutdown
  end
end
