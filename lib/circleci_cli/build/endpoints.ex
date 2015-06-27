defmodule CircleciCli.Build.Endpoints do
  def details(user, project, build_number) do
    "/project/#{user}/#{project}/#{build_num}"
  end

  def artifacts(user, project, build_number) do
    "/project/#{user}/#{project}/#{build_num}/artifacts"
  end

  def retry(user, project, build_number) do
    "/project/#{user}/#{project}/#{build_num}/retry"
  end

  def cancel(user, project, build_number) do
    " /project/#{user}/#{project}/#{build_num}/cancel"
  end

  def trigger(user, project, branch) do
    "/project/#{user}/#{project}/tree/#{branch}"
  end
end
