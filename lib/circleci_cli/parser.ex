defmodule CircleciCli.Parser do
  def parse_args(token, args) do
    case parsed_args(args) do
      { [help:  true],  _, _ }     -> :help
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
end
