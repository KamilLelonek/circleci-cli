defmodule CircleciCli.InterpreterTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  require CircleciCli.Parser,                  as: Parser
  require CircleciCli.Interpreter,             as: Interpreter
  require CircleciCli.Persistence.Credentials, as: Credentials

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

  test "user command" do
    # result = "https://circleci.com/api/v1/me?circle-token=#{@token}"
    assert_parse ["user"], {:user, @token}
  end

  test "projects command" do
    # result = "https://circleci.com/api/v1/projects?circle-token=#{@token}"
    assert_parse ["projects"], {:projects, @token}
  end

  test "builds command" do
    # result = "https://circleci.com/api/v1/recent-builds?circle-token=#{@token}"
    assert_parse ["builds"], {:recent_builds, @token}
  end

  test "clear-cache command" do
    # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/build-cache?circle-token=#{@token}"
    assert_parse ["clear-cache", "--user=#{@user}", "--project=#{@project}"], {:project_clear_cache, @token, @user, @project}
    assert_parse ["clear-cache", "-u", @user, "-p", @project],                {:project_clear_cache, @token, @user, @project}
  end

   test "build command" do
    # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}?circle-token=#{@token}"
    assert_parse ["build", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], {:project_build, @token, @user, @project, @build}
    assert_parse ["build", "-u", @user, "-p", @project, "-n", "#{@build}"],                  {:project_build, @token, @user, @project, @build}
   end

   test "artifacts command" do
    # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}/artifacts?circle-token=#{@token}"
    assert_parse ["artifacts", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], {:project_build_artifacts, @token, @user, @project, @build}
    assert_parse ["artifacts", "-u", @user, "-p", @project, "-n", "#{@build}"],                  {:project_build_artifacts, @token, @user, @project, @build}
   end

   test "retry command" do
    # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}/retry?circle-token=#{@token}"
    assert_parse ["retry", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], {:project_build_retry, @token, @user, @project, @build}
    assert_parse ["retry", "-u", @user, "-p", @project, "-n", "#{@build}"],                  {:project_build_retry, @token, @user, @project, @build}
   end

   test "cancel command" do
    # result = "https://circleci.com/api/v1 /project/#{@user}/#{@project}/#{@build}/cancel?circle-token=#{@token}"
    assert_parse ["cancel", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], {:project_build_cancel, @token, @user, @project, @build}
    assert_parse ["cancel", "-u", @user, "-p", @project, "-n", "#{@build}"],                  {:project_build_cancel, @token, @user, @project, @build}
   end

   test "trigger command" do
    # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/tree/master?circle-token=#{@token}"
    assert_parse ["trigger", "--user=#{@user}", "--project=#{@project}", "--branch=master"], {:project_build_trigger, @token, @user, @project, @branch}
    assert_parse ["trigger", "-u", @user, "-p", @project, "-b", @branch],                    {:project_build_trigger, @token, @user, @project, @branch}
   end

   test "project-key command" do
    # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/ssh-key?circle-token=#{@token}"
    assert_parse ["project-key", "--user=#{@user}", "--project=#{@project}", "--key=#{@key}"], {:project_add_ssh_key, @token, @user, @project, @key}
    assert_parse ["project-key", "-u", @user, "-p", @project, "-k", @key],                     {:project_add_ssh_key, @token, @user, @project, @key}
   end

   test "user-key command" do
    # result = "https://circleci.com/api/v1/user/ssh-key?circle-token=#{@token}"
    assert_parse ["user-key", "--key=#{@key}"], {:user_add_ssh_key, @token, @key}
    assert_parse ["user-key", "-k", @key],      {:user_add_ssh_key, @token, @key}
   end

  test "heroku-key command" do
    # result = "https://circleci.com/api/v1/user/heroku-key?circle-token=#{@token}"
    assert_parse ["heroku-key", "--key=#{@key}"], {:user_add_heroku_key, @token, @key}
    assert_parse ["heroku-key", "-k", @key],      {:user_add_heroku_key, @token, @key}
  end

  test "unknown command" do
    assert_capture_io_parse_and_interpret []
    assert_capture_io_parse_and_interpret ["whatever"]
  end

  defp assert_capture_io_parse_and_interpret(args) do
    assert_capture_io args, &parse_and_interpret/1
  end

  defp assert_capture_io(args, function ) do
    assert capture_io fn ->
      assert catch_exit(function.(args)) == :shutdown
    end
  end

  defp assert_parse(args, result) do
    assert parse_and_interpret(args) == result
  end

  defp parse_and_interpret(args) do
    args |> check_for_help |> Credentials.check |> Interpreter.interpret
  end

  defp check_for_help(args) do
    args |> Parser.parse |> Interpreter.check_for_help
  end
end
