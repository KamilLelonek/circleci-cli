defmodule CircleciCli.HTTP.BuilderTest do
  use ExUnit.Case

  import TestHelper

  require CircleciCli.HTTP.Builder, as: Builder

  @token   "token"
  @user    "user"
  @project "project"
  @build   1
  @key     "key"
  @branch  "master"

  setup do
    System.put_env("CIRCLECI_API_TOKEN", @token)
  end

  test "user command" do
    assert_build ["user"], [url: "https://circleci.com/api/v1/me?circle-token=#{@token}", method: :get, body: {}]
  end

  test "projects command" do
     assert_build ["projects"], [url: "https://circleci.com/api/v1/projects?circle-token=#{@token}", method: :get, body: {}]
  end

  test "builds command" do
     assert_build ["builds"], [url: "https://circleci.com/api/v1/recent-builds?circle-token=#{@token}", method: :get, body: {}]
  end

  test "clear-cache command" do
    result = [url: "https://circleci.com/api/v1/project/#{@user}/#{@project}/build-cache?circle-token=#{@token}", method: :delete, body: {}]
    assert_build ["clear-cache", "--user=#{@user}", "--project=#{@project}"], result
    assert_build ["clear-cache", "-u", @user, "-p", @project],                result
  end

  test "build command" do
    result = [url: "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}?circle-token=#{@token}", method: :get, body: {}]
    assert_build ["build", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], result
    assert_build ["build", "-u", @user, "-p", @project, "-n", "#{@build}"],                  result
  end

  test "artifacts command" do
    result = [url: "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}/artifacts?circle-token=#{@token}", method: :get, body: {}]
    assert_build ["artifacts", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], result
    assert_build ["artifacts", "-u", @user, "-p", @project, "-n", "#{@build}"],                  result
  end

  test "retry command" do
    result = [url: "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}/retry?circle-token=#{@token}", method: :post, body: {}]
    assert_build ["retry", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], result
    assert_build ["retry", "-u", @user, "-p", @project, "-n", "#{@build}"],                  result
  end

  test "cancel command" do
    result = [url: "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}/cancel?circle-token=#{@token}", method: :post, body: {}]
    assert_build ["cancel", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], result
    assert_build ["cancel", "-u", @user, "-p", @project, "-n", "#{@build}"],                  result
  end

  test "trigger command" do
    result = [url: "https://circleci.com/api/v1/project/#{@user}/#{@project}/tree/master?circle-token=#{@token}", method: :post, body: {}]
    assert_build ["trigger", "--user=#{@user}", "--project=#{@project}", "--branch=master"], result
    assert_build ["trigger", "-u", @user, "-p", @project, "-b", @branch],                    result
  end

  test "project-key command" do
    result = [url: "https://circleci.com/api/v1/project/#{@user}/#{@project}/ssh-key?circle-token=#{@token}", method: :post, body: {}]
    assert_build ["project-key", "--user=#{@user}", "--project=#{@project}", "--key=#{@key}"], result
    assert_build ["project-key", "-u", @user, "-p", @project, "-k", @key],                     result
  end

  test "user-key command" do
    result = [url: "https://circleci.com/api/v1/user/ssh-key?circle-token=#{@token}", method: :post, body: "key"]
    assert_build ["user-key", "--key=#{@key}"], result
    assert_build ["user-key", "-k", @key],      result
  end

  test "heroku-key command" do
    result = [url: "https://circleci.com/api/v1/user/heroku-key?circle-token=#{@token}", method: :post, body: "key"]
    assert_build ["heroku-key", "--key=#{@key}"], result
    assert_build ["heroku-key", "-k", @key],      result
  end

  defp assert_build(args, result) do
    assert (args |> parse_and_interpret |> Builder.build_request) == result
  end
end
