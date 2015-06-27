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

  def add_ssh_key(key) do
    "/user/ssh-key"
  end

  def add_heroku_key(key) do
    "/user/heroku-key"
  end
end
