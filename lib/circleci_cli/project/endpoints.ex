defmodule CircleciCli.Project.Endpoints do
  def builds(user, project) do
    "/project/#{user}/#{project}"
  end

  def ssh_key(user, project, key) do
    "/project/#{user}/#{project}/ssh-key"
  end

  def cache(user, project) do
    "/project/#{user}/#{project}/build-cache"
  end
end
