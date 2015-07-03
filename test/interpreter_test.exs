defmodule CircleciCli.InterpreterTest do
  use ExUnit.Case

  require CircleciCli.Parser,      as: Parser
  require CircleciCli.Interpreter, as: Interpreter

  @token   "token"
  @user    "user"
  @project "project"
  @build   1
  @key     "key"
  @branch  "master"

  test "help command" do
    assert catch_exit(parse_and_interpret ["--help"]) == :shutdown
    assert catch_exit(parse_and_interpret ["-h"])     == :shutdown
  end

  test "user command" do
    result = "https://circleci.com/api/v1/me?circle-token=#{@token}"
    assert_parse ["user"],                      result
    assert_parse ["user", "--token=#{@token}"], result
  end

  test "projects command" do
    result = "https://circleci.com/api/v1/projects?circle-token=#{@token}"
    assert_parse ["projects"],                      result
    assert_parse ["projects", "--token=#{@token}"], result
  end

  test "builds command" do
    assert_parse ["builds"], "https://circleci.com/api/v1/recent-builds?circle-token=#{@token}"
  end

  test "clear-cache command" do
    result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/build-cache?circle-token=#{@token}"
    assert_parse ["clear-cache", "--user=#{@user}", "--project=#{@project}"], result
    assert_parse ["clear-cache", "-u", @user, "-p", @project],                result
  end

  test "build command" do
    result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}?circle-token=#{@token}"
    assert_parse ["build", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], result
    assert_parse ["build", "-u", @user, "-p", @project, "-n", "#{@build}"],                  result
  end

  test "artifacts command" do
    result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}/artifacts?circle-token=#{@token}"
    assert_parse ["artifacts", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], result
    assert_parse ["artifacts", "-u", @user, "-p", @project, "-n", "#{@build}"],                  result
  end

  test "retry command" do
    result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}/retry?circle-token=#{@token}"
    assert_parse ["retry", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], result
    assert_parse ["retry", "-u", @user, "-p", @project, "-n", "#{@build}"],                  result
  end

  test "cancel command" do
    result = "https://circleci.com/api/v1 /project/#{@user}/#{@project}/#{@build}/cancel?circle-token=#{@token}"
    assert_parse ["cancel", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], result
    assert_parse ["cancel", "-u", @user, "-p", @project, "-n", "#{@build}"],                  result
  end

  test "trigger command" do
    result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/tree/master?circle-token=#{@token}"
    assert_parse ["trigger", "--user=#{@user}", "--project=#{@project}", "--branch=master"], result
    assert_parse ["trigger", "-u", @user, "-p", @project, "-b", @branch],                    result
  end

  test "project-key command" do
    result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/ssh-key?circle-token=#{@token}"
    assert_parse ["project-key", "--user=#{@user}", "--project=#{@project}", "--key=#{@key}"], result
    assert_parse ["project-key", "-u", @user, "-p", @project, "-k", @key],                     result
  end

  test "user-key command" do
    result = "https://circleci.com/api/v1/user/ssh-key?circle-token=#{@token}"
    {:user_add_ssh_key, @token, @key}
    assert_parse ["user-key", "--key=#{@key}"], result
    assert_parse ["user-key", "-k", @key],      result
  end

  test "heroku-key command" do
    result = "https://circleci.com/api/v1/user/heroku-key?circle-token=#{@token}"
    assert_parse ["heroku-key", "--key=#{@key}"], result
    assert_parse ["heroku-key", "-k", @key],      result
  end

  test "any other command" do
    assert catch_exit(parse_and_interpret [])           == :shutdown
    assert catch_exit(parse_and_interpret ["whatever"]) == :shutdown
  end

  defp assert_parse(args, result) do
    assert parse_and_interpret(args) == [url: result]
  end

  defp parse_and_interpret(args) do
    Parser.parse_args(@token, args) |> Interpreter.interpret_command
  end
end
