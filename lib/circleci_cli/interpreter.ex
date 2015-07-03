defmodule CircleciCli.Interpreter do
  require CircleciCli.Build.Endpoints,   as: BuildEndpoints
  require CircleciCli.Project.Endpoints, as: ProjectEndpoints
  require CircleciCli.User.Endpoints,    as: UserEndpoints
  require CircleciCli.HTTP.URL,          as: URL

  def interpret_command({:user,                    token}),                          do: URL.build(UserEndpoints.me, token)
  def interpret_command({:projects,                token}),                          do: URL.build(UserEndpoints.projects, token)
  def interpret_command({:recent_builds,           token}),                          do: URL.build(UserEndpoints.recent_builds, token)
  def interpret_command({:user_add_ssh_key,        token, key}),                     do: URL.build(UserEndpoints.ssh_key(key), token)
  def interpret_command({:user_add_heroku_key,     token, key}),                     do: URL.build(UserEndpoints.heroku_key(key), token)
  def interpret_command({:project,                 token, user, project}),           do: URL.build(ProjectEndpoints.builds(user, project), token)
  def interpret_command({:project_clear_cache,     token, user, project}),           do: URL.build(ProjectEndpoints.cache(user, project), token)
  def interpret_command({:project_build_trigger,   token, user, project, branch}),   do: URL.build(ProjectEndpoints.trigger(user, project, branch), token)
  def interpret_command({:project_add_ssh_key,     token, user, project, key}),      do: URL.build(ProjectEndpoints.ssh_key(user, project, key), token)
  def interpret_command({:project_build,           token, user, project, build_no}), do: URL.build(BuildEndpoints.details(user, project, build_no), token)
  def interpret_command({:project_build_artifacts, token, user, project, build_no}), do: URL.build(BuildEndpoints.artifacts(user, project, build_no), token)
  def interpret_command({:project_build_retry,     token, user, project, build_no}), do: URL.build(BuildEndpoints.retry(user, project, build_no), token)
  def interpret_command({:project_build_cancel,    token, user, project, build_no}), do: URL.build(BuildEndpoints.cancel(user, project, build_no), token)

  def interpret_command(:help) do
    IO.puts """
      Usage: circleci [command] [--token=CIRCLECI_API_TOKEN]

        You don't have to provide CIRCLECI_API_TOKEN each time, instead you can store it in environment variable.
        You can create one here: https://circleci.com/account/api

      You can use the following commands:
        -h, --help                                  Displays this help message.
        user                                        Provides information about the signed in user.
        projects                                    List of all the projects you're following on CircleCI, with build information organized by branch.
        builds                                      Build summary for each of the last 30 recent builds, ordered by build number.
        project     -u USER -p PROJECT              Build summary for each of the last 30 builds for a single git repo.
        build       -u USER -p PROJECT -n BUILD     Full details for a single build. The response includes all of the fields from the build summary.
        artifacts   -u USER -p PROJECT -n BUILD     Lists the artifacts produced by a given build.
        retry       -u USER -p PROJECT -n BUILD     Retries the build, returns a summary of the new build.
        cancel      -u USER -p PROJECT -n BUILD     Cancels the build, returns a summary of the build.
        trigger     -u USER -p PROJECT -b BRANCH    Triggers a new build, returns a summary of the build.
        clear-cache -u USER -p PROJECT              Clears the cache for a project.
        project-key -u USER -p PROJECT -k KEY       Creates an ssh key used to access external systems that require SSH key-based authentication.
        user-key    -k KEY                          Adds a CircleCI key to your Github User account.
        heroku-key  -k KEY                          Adds your Heroku API key to CircleCI, takes apikey as form param name.

      All flags have abbrevations and they are equivalent:
        -h,       --help
        -t VALUE, --token=VALUE
        -u VALUE, --user=VALUE
        -p VALUE, --project=VALUE
        -n VALUE, --build_no=VALUE
        -b VALUE, --branch=VALUE
        -k VALUE, --key=VALUE
    """
    exit :shutdown
  end
end
