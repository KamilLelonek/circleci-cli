defmodule CircleciCli.Parser do
  @switches [
        help:    :boolean,
        user:    :string,
        project: :string,
        build:   :integer,
        branch:  :string,
        key:     :string,
        token:   :string
      ]

  @aliases [
        h: :help,
        u: :user,
        p: :project,
        n: :build,
        b: :branch,
        k: :key,
        t: :token
      ]

  def parse(args) do
    OptionParser.parse(
      args,
      switches: @switches,
      aliases:  @aliases
    )
  end
end
