defmodule CircleciCli.User.Endpoints do
  def me do
    "/me"
  end

  def projects do
    "/projects"
  end

  def recent_builds do
    "/recent-builds"
  end

  def ssh_key do
    "/user/ssh-key"
  end

  def heroku_key do
    "/user/heroku-key"
  end
end
