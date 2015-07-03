defmodule CircleciCli.Parser do
  def parse_args(token, args) do
    case parsed_args(args) do
      { [help: true],                                   _,               _ } -> :help
      { _,                                              ["user"],        _ } -> { :user,                    token                        }
      { _,                                              ["projects"],    _ } -> { :projects,                token                        }
      { _,                                              ["builds"],      _ } -> { :recent_builds,           token                        }
      { [user: user, project: project],                 ["project"],     _ } -> { :project,                 token, user, project         }
      { [user: user, project: project],                 ["clear-cache"], _ } -> { :project_clear_cache,     token, user, project         }
      { [user: user, project: project, build:  build],  ["build"],       _ } -> { :project_build,           token, user, project, build  }
      { [user: user, project: project, build:  build],  ["artifacts"],   _ } -> { :project_build_artifacts, token, user, project, build  }
      { [user: user, project: project, build:  build],  ["retry"],       _ } -> { :project_build_retry,     token, user, project, build  }
      { [user: user, project: project, build:  build],  ["cancel"],      _ } -> { :project_build_cancel,    token, user, project, build  }
      { [user: user, project: project, branch: branch], ["trigger"],     _ } -> { :project_build_trigger,   token, user, project, branch }
      { [user: user, project: project, key:    key],    ["project-key"], _ } -> { :project_add_ssh_key,     token, user, project, key    }
      { [key:  key],                                    ["user-key"],    _ } -> { :user_add_ssh_key,        token, key                   }
      { [key:  key],                                    ["heroku-key"],  _ } -> { :user_add_heroku_key,     token, key                   }
      _                                                                      -> :help
    end
  end

  defp parsed_args(args) do
    OptionParser.parse(
      args,
      switches: [
        help:    :boolean,
        user:    :string,
        project: :string,
        build:   :integer,
        branch:  :string,
        key:     :string
      ],
      aliases:  [
        h: :help,
        u: :user,
        p: :project,
        n: :build,
        b: :branch,
        k: :key
      ]
    )
  end
end
