defmodule CircleciCli.ParserTest do
  use ExUnit.Case

  require CircleciCli.Parser, as: Praser

  test "help command" do
    assert Praser.parse_args("", ["--help"]) == :help
    assert Praser.parse_args("", ["--h"])    == :help
  end

  test "user command" do
    assert Praser.parse_args("", ["user"]) == {:user, ""}
  end

  test "projects command" do
    assert Praser.parse_args("", ["projects"]) == {:projects, ""}
  end

  test "builds command" do
    assert Praser.parse_args("", ["builds"]) == {:recent_builds, ""}
  end

  test "clear-cache command" do
    assert Praser.parse_args("", ["clear-cache", "--user=user", "--project=project"]) == {:project_clear_cache, "", "user", "project"}
    assert Praser.parse_args("", ["clear-cache", "-u", "user", "-p", "project"])      == {:project_clear_cache, "", "user", "project"}
  end

  test "build command" do
    assert Praser.parse_args("", ["build", "--user=user", "--project=project", "--build=1"]) == {:project_build, "", "user", "project", 1}
    assert Praser.parse_args("", ["build", "-u", "user", "-p", "project", "-n", "1"])        == {:project_build, "", "user", "project", 1}
  end

  test "artifacts command" do
    assert Praser.parse_args("", ["artifacts", "--user=user", "--project=project", "--build=1"]) == {:project_build_artifacts, "", "user", "project", 1}
    assert Praser.parse_args("", ["artifacts", "-u", "user", "-p", "project", "-n", "1"])        == {:project_build_artifacts, "", "user", "project", 1}
  end

  test "retry command" do
    assert Praser.parse_args("", ["retry", "--user=user", "--project=project", "--build=1"]) == {:project_build_retry, "", "user", "project", 1}
    assert Praser.parse_args("", ["retry", "-u", "user", "-p", "project", "-n", "1"])        == {:project_build_retry, "", "user", "project", 1}
  end

  test "cancel command" do
    assert Praser.parse_args("", ["cancel", "--user=user", "--project=project", "--build=1"]) == {:project_build_cancel, "", "user", "project", 1}
    assert Praser.parse_args("", ["cancel", "-u", "user", "-p", "project", "-n", "1"])        == {:project_build_cancel, "", "user", "project", 1}
  end

  test "trigger command" do
    assert Praser.parse_args("", ["trigger", "--user=user", "--project=project", "--branch=master"]) == {:project_build_trigger, "", "user", "project", "master"}
    assert Praser.parse_args("", ["trigger", "-u", "user", "-p", "project", "-b", "master"])         == {:project_build_trigger, "", "user", "project", "master"}
  end

  test "project-key command" do
    assert Praser.parse_args("", ["project-key", "--user=user", "--project=project", "--key=key"]) == {:project_add_ssh_key, "", "user", "project", "key"}
    assert Praser.parse_args("", ["project-key", "-u", "user", "-p", "project", "-k", "key"])      == {:project_add_ssh_key, "", "user", "project", "key"}
  end

  test "user-key command" do
    assert Praser.parse_args("", ["user-key", "--key=key"]) == {:user_add_ssh_key, "", "key"}
    assert Praser.parse_args("", ["user-key", "-k", "key"]) == {:user_add_ssh_key, "", "key"}
  end

  test "heroku-key command" do
    assert Praser.parse_args("", ["heroku-key", "--key=key"]) == {:user_add_heroku_key, "", "key"}
    assert Praser.parse_args("", ["heroku-key", "-k", "key"]) == {:user_add_heroku_key, "", "key"}
  end

  test "any other command" do
    assert Praser.parse_args("", [])           == :help
    assert Praser.parse_args("", ["whatever"]) == :help
  end
end
