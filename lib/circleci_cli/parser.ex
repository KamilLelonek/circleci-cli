defmodule CircleciCli.Parser do
  def parse_args(args) do
    case parsed_args(args) do
      { [help:  true],  _, _ }     -> :help
      { _, _, [{"--token", nil}] } -> :help

      { _,                                                  ["user"],        _ } -> :user
      { _,                                                  ["projects"],    _ } -> :projects
      { _,                                                  ["builds"],      _ } -> :recent_builds
      { [user: user, project: project],                     ["project"],     _ } -> :project
      { [user: user, project: project],                     ["clear-cache"], _ } -> :project_clear_cache
      { [user: user, project: project, build_no: build_no], ["build"],       _ } -> :project_build
      { [user: user, project: project, build_no: build_no], ["artifacts"],   _ } -> :project_build_artifacts
      { [user: user, project: project, build_no: build_no], ["retry"],       _ } -> :project_build_retry
      { [user: user, project: project, build_no: build_no], ["cancel"],      _ } -> :project_build_cancel
      { [user: user, project: project, branch:   branch],   ["trigger"],     _ } -> :project_build_trigger
      { [user: user, project: project, key:      key],      ["project-key"], _ } -> :project_add_ssh_key
      { [key:  key],                                        ["user-key"],    _ } -> :user_add_ssh_key
      { [key:  key],                                        ["heroku-key"],  _ } -> :user_add_heroku_key
      _                                                                          -> :help
    end
  end

  defp parsed_args(args) do
    OptionParser.parse(
      args,
      switches: [
        help:     :boolean,
        token:    :string,
        user:     :string,
        project:  :string,
        build_no: :integer,
        branch:   :string,
        key:      :string
      ],
      aliases:  [
        h: :help,
        t: :token,
        u: :user,
        p: :project,
        n: :build_no,
        b: :branch,
        k: :key
      ]
    )
  end

  defp usage do
    """
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
  end
end
