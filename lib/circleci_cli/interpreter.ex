defmodule CircleciCli.Interpreter do
  require CircleciCli.Build.Endpoints,   as: BuildEndpoints
  require CircleciCli.Project.Endpoints, as: ProjectEndpoints
  require CircleciCli.User.Endpoints,    as: UserEndpoints
  require CircleciCli.HTTP.URL,          as: URL

  def check_for_help({switches, command, _}) do
    case extract_help_flag(switches) do
      nil  -> {switches, command}
      true -> show_help
    end
  end

  defp extract_help_flag(switches), do: Keyword.get(switches, :help)

  def interpret({token, command, switches}) do
    # case args do
    #   { _,                                              ["user"],        _ } -> { :user,                    token                        }
    #   { _,                                              ["projects"],    _ } -> { :projects,                token                        }
    #   { _,                                              ["builds"],      _ } -> { :recent_builds,           token                        }
    #   { [user: user, project: project],                 ["project"],     _ } -> { :project,                 token, user, project         }
    #   { [user: user, project: project],                 ["clear-cache"], _ } -> { :project_clear_cache,     token, user, project         }
    #   { [user: user, project: project, build:  build],  ["build"],       _ } -> { :project_build,           token, user, project, build  }
    #   { [user: user, project: project, build:  build],  ["artifacts"],   _ } -> { :project_build_artifacts, token, user, project, build  }
    #   { [user: user, project: project, build:  build],  ["retry"],       _ } -> { :project_build_retry,     token, user, project, build  }
    #   { [user: user, project: project, build:  build],  ["cancel"],      _ } -> { :project_build_cancel,    token, user, project, build  }
    #   { [user: user, project: project, branch: branch], ["trigger"],     _ } -> { :project_build_trigger,   token, user, project, branch }
    #   { [user: user, project: project, key:    key],    ["project-key"], _ } -> { :project_add_ssh_key,     token, user, project, key    }
    #   { [key:  key],                                    ["user-key"],    _ } -> { :user_add_ssh_key,        token, key                   }
    #   { [key:  key],                                    ["heroku-key"],  _ } -> { :user_add_heroku_key,     token, key                   }
    #   _                                                                      -> :help
    # end
  end

  def interpret_command({:user,                    token}),                          do: [url: URL.build(UserEndpoints.me, token)]
  def interpret_command({:projects,                token}),                          do: [url: URL.build(UserEndpoints.projects, token)]
  def interpret_command({:recent_builds,           token}),                          do: [url: URL.build(UserEndpoints.recent_builds, token)]
  def interpret_command({:user_add_ssh_key,        token, key}),                     do: [url: URL.build(UserEndpoints.ssh_key(key), token)]
  def interpret_command({:user_add_heroku_key,     token, key}),                     do: [url: URL.build(UserEndpoints.heroku_key(key), token)]
  def interpret_command({:project,                 token, user, project}),           do: [url: URL.build(ProjectEndpoints.builds(user, project), token)]
  def interpret_command({:project_clear_cache,     token, user, project}),           do: [url: URL.build(ProjectEndpoints.cache(user, project), token)]
  def interpret_command({:project_build_trigger,   token, user, project, branch}),   do: [url: URL.build(ProjectEndpoints.trigger(user, project, branch), token)]
  def interpret_command({:project_add_ssh_key,     token, user, project, key}),      do: [url: URL.build(ProjectEndpoints.ssh_key(user, project, key), token)]
  def interpret_command({:project_build,           token, user, project, build_no}), do: [url: URL.build(BuildEndpoints.details(user, project, build_no), token)]
  def interpret_command({:project_build_artifacts, token, user, project, build_no}), do: [url: URL.build(BuildEndpoints.artifacts(user, project, build_no), token)]
  def interpret_command({:project_build_retry,     token, user, project, build_no}), do: [url: URL.build(BuildEndpoints.retry(user, project, build_no), token)]
  def interpret_command({:project_build_cancel,    token, user, project, build_no}), do: [url: URL.build(BuildEndpoints.cancel(user, project, build_no), token)]

  def show_help do
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
        -n VALUE, --build=VALUE
        -b VALUE, --branch=VALUE
        -k VALUE, --key=VALUE
    """
    exit :shutdown
  end
end
