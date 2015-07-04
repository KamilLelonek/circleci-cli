defmodule CircleciCli.Project.Endpoints do
  def builds(user, project) do
    "/project/#{user}/#{project}"
  end

  def ssh_key(user, project) do
    "/project/#{user}/#{project}/ssh-key"
  end

  def cache(user, project) do
    "/project/#{user}/#{project}/build-cache"
  end

  def trigger(user, project, branch) do
    "/project/#{user}/#{project}/tree/#{branch}"
  end
end
