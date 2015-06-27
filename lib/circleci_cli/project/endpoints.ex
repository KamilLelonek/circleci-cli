defmodule CircleciCli.Project.Endpoints do
  def builds(user, project) do
    "/project/#{user}/#{project}"
  end

  def add_ssh_key(user, project, key) do
    "/project/#{user}/#{project}/ssh-key"
  end

  def clear_cache(user, project) do
    "/project/#{user}/#{project}/build-cache"
  end
end
