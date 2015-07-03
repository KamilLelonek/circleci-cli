defmodule CircleciCli.Build.Endpoints do
  def details(user, project, build_number) do
    "/project/#{user}/#{project}/#{build_number}"
  end

  def artifacts(user, project, build_number) do
    "/project/#{user}/#{project}/#{build_number}/artifacts"
  end

  def retry(user, project, build_number) do
    "/project/#{user}/#{project}/#{build_number}/retry"
  end

  def cancel(user, project, build_number) do
    " /project/#{user}/#{project}/#{build_number}/cancel"
  end
end
