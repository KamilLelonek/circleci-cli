defmodule CircleciCli.Parser do
  def parse(args) do
    OptionParser.parse(
      args,
      switches: [
        help:    :boolean,
        user:    :string,
        project: :string,
        build:   :integer,
        branch:  :string,
        key:     :string,
        token:   :string
      ],
      aliases:  [
        h: :help,
        u: :user,
        p: :project,
        n: :build,
        b: :branch,
        k: :key,
        t:  :token
      ]
    )
  end
end
