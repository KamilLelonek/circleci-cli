defmodule CircleciCli.ParserTest do
  use ExUnit.Case

  require CircleciCli.Parser, as: Parser

  test "help command" do
    result = {[help: true], [], []}
    assert_parse ["--help"], result
    assert_parse ["-h"],     result
  end

  test "any command" do
    assert_parse [],                                          {[],                [],          []}
    assert_parse ["-f", "unknown"],                           {[],                [],          [{"-f", "unknown"}]}
    assert_parse ["command"],                                 {[],                ["command"], []}
    assert_parse ["command", "-f", "unknown"],                {[],                ["command"], [{"-f", "unknown"}]}
    assert_parse ["-u", "user"],                              {[user: "user"],    [],          []}
    assert_parse ["--user=user"],                             {[user: "user"],    [],          []}
    assert_parse ["--flag=unknown", "-f=unknown"],            {[flag: "unknown"], [],          [{"-f", "unknown"}]}
    assert_parse ["--user=user", "command"],                  {[user: "user"],    ["command"], []}
    assert_parse ["--flag=unknown", "command", "-f=unknown"], {[flag: "unknown"], ["command"], [{"-f", "unknown"}]}
  end

  defp assert_parse(args, result) do
    assert Parser.parse(args) == result
  end
end
