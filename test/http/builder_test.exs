defmodule CircleciCli.HTTP.BuilderTest do
  use ExUnit.Case

  import TestHelper

  # test "user command" do
  #   # result = "https://circleci.com/api/v1/me?circle-token=#{@token}"
  #   assert_build ["user"], {:user, @token}
  # end

  # test "projects command" do
  #   # result = "https://circleci.com/api/v1/projects?circle-token=#{@token}"
  #   assert_build ["projects"], {:projects, @token}
  # end

  # test "builds command" do
  #   # result = "https://circleci.com/api/v1/recent-builds?circle-token=#{@token}"
  #   assert_build ["builds"], {:recent_builds, @token}
  # end

  # test "clear-cache command" do
  #   # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/build-cache?circle-token=#{@token}"
  #   assert_build ["clear-cache", "--user=#{@user}", "--project=#{@project}"], {:project_clear_cache, @token, @user, @project}
  #   assert_build ["clear-cache", "-u", @user, "-p", @project],                {:project_clear_cache, @token, @user, @project}
  # end

  #  test "build command" do
  #   # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}?circle-token=#{@token}"
  #   assert_build ["build", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], {:project_build, @token, @user, @project, @build}
  #   assert_build ["build", "-u", @user, "-p", @project, "-n", "#{@build}"],                  {:project_build, @token, @user, @project, @build}
  #  end

  #  test "artifacts command" do
  #   # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}/artifacts?circle-token=#{@token}"
  #   assert_build ["artifacts", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], {:project_build_artifacts, @token, @user, @project, @build}
  #   assert_build ["artifacts", "-u", @user, "-p", @project, "-n", "#{@build}"],                  {:project_build_artifacts, @token, @user, @project, @build}
  #  end

  #  test "retry command" do
  #   # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/#{@build}/retry?circle-token=#{@token}"
  #   assert_build ["retry", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], {:project_build_retry, @token, @user, @project, @build}
  #   assert_build ["retry", "-u", @user, "-p", @project, "-n", "#{@build}"],                  {:project_build_retry, @token, @user, @project, @build}
  #  end

  #  test "cancel command" do
  #   # result = "https://circleci.com/api/v1 /project/#{@user}/#{@project}/#{@build}/cancel?circle-token=#{@token}"
  #   assert_build ["cancel", "--user=#{@user}", "--project=#{@project}", "--build=#{@build}"], {:project_build_cancel, @token, @user, @project, @build}
  #   assert_build ["cancel", "-u", @user, "-p", @project, "-n", "#{@build}"],                  {:project_build_cancel, @token, @user, @project, @build}
  #  end

  #  test "trigger command" do
  #   # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/tree/master?circle-token=#{@token}"
  #   assert_build ["trigger", "--user=#{@user}", "--project=#{@project}", "--branch=master"], {:project_build_trigger, @token, @user, @project, @branch}
  #   assert_build ["trigger", "-u", @user, "-p", @project, "-b", @branch],                    {:project_build_trigger, @token, @user, @project, @branch}
  #  end

  #  test "project-key command" do
  #   # result = "https://circleci.com/api/v1/project/#{@user}/#{@project}/ssh-key?circle-token=#{@token}"
  #   assert_build ["project-key", "--user=#{@user}", "--project=#{@project}", "--key=#{@key}"], {:project_add_ssh_key, @token, @user, @project, @key}
  #   assert_build ["project-key", "-u", @user, "-p", @project, "-k", @key],                     {:project_add_ssh_key, @token, @user, @project, @key}
  #  end

  #  test "user-key command" do
  #   # result = "https://circleci.com/api/v1/user/ssh-key?circle-token=#{@token}"
  #   assert_build ["user-key", "--key=#{@key}"], {:user_add_ssh_key, @token, @key}
  #   assert_build ["user-key", "-k", @key],      {:user_add_ssh_key, @token, @key}
  #  end

  # test "heroku-key command" do
  #   # result = "https://circleci.com/api/v1/user/heroku-key?circle-token=#{@token}"
  #   assert_build ["heroku-key", "--key=#{@key}"], {:user_add_heroku_key, @token, @key}
  #   assert_build ["heroku-key", "-k", @key],      {:user_add_heroku_key, @token, @key}
  # end
end
