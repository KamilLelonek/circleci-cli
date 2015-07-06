defmodule CircleciCli.CliTest do
  use ExUnit.Case

  import TestHelper

  require CircleciCli.Persistence.Token, as: Token

  @token "token"

  setup do
    Token.clear

    on_exit fn ->
      Token.clear
    end
  end

  test "should store a given token" do
    assert_capture_io [], &check_for_credentials/1

    CircleciCli.Cli.main(["configure", "-t", @token])

    assert check_for_credentials([]) == {@token, [], []}
    assert Token.read                == {:ok, @token}
  end
end
