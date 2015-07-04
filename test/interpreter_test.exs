defmodule CircleciCli.InterpreterTest do
  use ExUnit.Case

  import TestHelper

  @token   "token"
  @user    "user"
  @project "project"
  @build   1
  @key     "key"
  @branch  "master"

  setup do
    System.put_env("CIRCLECI_API_TOKEN", @token)
  end

  test "help command" do
    assert_capture_io_check_for_help ["--help"]
    assert_capture_io_check_for_help ["-h"]
    assert_capture_io_check_for_help ["--help",      "command"]
    assert_capture_io_check_for_help ["-h",          "command"]
    assert_capture_io_check_for_help ["--help",      "--flag=flag"]
    assert_capture_io_check_for_help ["-h",          "-f", "flag"]
    assert_capture_io_check_for_help ["command",     "--help"]
    assert_capture_io_check_for_help ["command",     "-h"]
    assert_capture_io_check_for_help ["--flag=flag", "--help"]
    assert_capture_io_check_for_help ["-f", "flag",  "-h"]
  end

  defp assert_capture_io_check_for_help(args) do
    assert_capture_io args, &check_for_help/1
  end

  test "unknown command" do
    assert_capture_io_parse_and_interpret []
    assert_capture_io_parse_and_interpret ["whatever"]
  end

  defp assert_capture_io_parse_and_interpret(args) do
    assert_capture_io args, &parse_and_interpret/1
  end
end
