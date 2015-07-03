defmodule CircleciCli.ParserTest do
  use ExUnit.Case

  require CircleciCli.Parser, as: Praser

  test "help command" do
    assert_parse ["--help"], :help
    assert_parse ["--h"],    :help
  end

  test "user command" do
    result = {:user, ""}
    assert_parse ["user"],                  result
    assert_parse ["user", "--token=token"], result
  end

  test "projects command" do
    result = {:projects, ""}
    assert_parse ["projects"],                  result
    assert_parse ["projects", "--token=token"], result
  end

  test "builds command" do
    assert_parse ["builds"], {:recent_builds, ""}
  end

  test "clear-cache command" do
    result = {:project_clear_cache, "", "user", "project"}
    assert_parse ["clear-cache", "--user=user", "--project=project"], result
    assert_parse ["clear-cache", "-u", "user", "-p", "project"],      result
  end

  test "build command" do
    result = {:project_build, "", "user", "project", 1}
    assert_parse ["build", "--user=user", "--project=project", "--build=1"], result
    assert_parse ["build", "-u", "user", "-p", "project", "-n", "1"],        result
  end

  test "artifacts command" do
    result = {:project_build_artifacts, "", "user", "project", 1}
    assert_parse ["artifacts", "--user=user", "--project=project", "--build=1"], result
    assert_parse ["artifacts", "-u", "user", "-p", "project", "-n", "1"],        result
  end

  test "retry command" do
    result = {:project_build_retry, "", "user", "project", 1}
    assert_parse ["retry", "--user=user", "--project=project", "--build=1"], result
    assert_parse ["retry", "-u", "user", "-p", "project", "-n", "1"],        result
  end

  test "cancel command" do
    result = {:project_build_cancel, "", "user", "project", 1}
    assert_parse ["cancel", "--user=user", "--project=project", "--build=1"], result
    assert_parse ["cancel", "-u", "user", "-p", "project", "-n", "1"],        result
  end

  test "trigger command" do
    result = {:project_build_trigger, "", "user", "project", "master"}
    assert_parse ["trigger", "--user=user", "--project=project", "--branch=master"], result
    assert_parse ["trigger", "-u", "user", "-p", "project", "-b", "master"],         result
  end

  test "project-key command" do
    result = {:project_add_ssh_key, "", "user", "project", "key"}
    assert_parse ["project-key", "--user=user", "--project=project", "--key=key"], result
    assert_parse ["project-key", "-u", "user", "-p", "project", "-k", "key"],      result
  end

  test "user-key command" do
    result = {:user_add_ssh_key, "", "key"}
    assert_parse ["user-key", "--key=key"], result
    assert_parse ["user-key", "-k", "key"], result
  end

  test "heroku-key command" do
    result = {:user_add_heroku_key, "", "key"}
    assert_parse ["heroku-key", "--key=key"], result
    assert_parse ["heroku-key", "-k", "key"], result
  end

  test "any other command" do
    assert_parse [],           :help
    assert_parse ["whatever"], :help
  end

  defp assert_parse(args, result) do
    assert Praser.parse_args("", args) == result
  end
end
