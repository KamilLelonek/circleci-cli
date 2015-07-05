defmodule CircleciCli.HTTP.Builder do
  require CircleciCli.User.Endpoints,    as: UserEndpoints
  require CircleciCli.Project.Endpoints, as: ProjectEndpoints
  require CircleciCli.Build.Endpoints,   as: BuildEndpoints
  require CircleciCli.HTTP.URL,          as: URL

  def build_request({:user, token}) do
    [
      url:    URL.build(UserEndpoints.me, token),
      method: :get
    ]
  end

  def build_request({:projects, token}) do
    [
      url:    URL.build(UserEndpoints.projects, token),
      method: :get
    ]
  end

  def build_request({:recent_builds, token}) do
    [
      url:    URL.build(UserEndpoints.recent_builds, token),
      method: :get
    ]
  end

  def build_request({:user_add_ssh_key, token}) do
    [
      url:    URL.build(UserEndpoints.ssh_key, token),
      method: :post
    ]
  end

  def build_request({:user_add_heroku_key, token, key}) do
    [
      url:    URL.build(UserEndpoints.heroku_key, token),
      method: :post,
			body:   "{apikey: #{key}}"
    ]
  end

  def build_request({:project, token, user, project}) do
    [
      url:    URL.build(ProjectEndpoints.builds(user, project), token),
      method: :get
    ]
  end

  def build_request({:project_clear_cache, token, user, project}) do
    [
      url:    URL.build(ProjectEndpoints.cache(user, project), token),
      method: :delete
    ]
  end

  def build_request({:project_build_trigger, token, user, project, branch}) do
    [
      url:    URL.build(ProjectEndpoints.trigger(user, project, branch), token),
      method: :post
    ]
  end

  def build_request({:project_create_ssh_key, token, user, project}) do
    [
      url:    URL.build(ProjectEndpoints.ssh_key(user, project), token),
      method: :post
    ]
  end

  def build_request({:project_build, token, user, project, build_no}) do
    [
      url:    URL.build(BuildEndpoints.details(user, project, build_no), token),
      method: :get
    ]
  end

  def build_request({:project_build_artifacts, token, user, project, build_no}) do
    [
      url:    URL.build(BuildEndpoints.artifacts(user, project, build_no), token),
      method: :get
    ]
  end

  def build_request({:project_build_retry, token, user, project, build_no}) do
    [
      url:    URL.build(BuildEndpoints.retry(user, project, build_no), token),
      method: :post
    ]
  end

  def build_request({:project_build_cancel, token, user, project, build_no}) do
    [
      url:    URL.build(BuildEndpoints.cancel(user, project, build_no), token),
      method: :post
    ]
  end
end
