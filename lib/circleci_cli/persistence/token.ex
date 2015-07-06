defmodule CircleciCli.Persistence.Token do
  @file_name ".circle_cli_token"
  @env_name  "CIRCLECI_API_TOKEN"

  def write(token), do: File.write(token_path, token)
  def read,         do: read_token_from_file File.read(token_path)

  def clear do
    File.rm token_path
    System.delete_env @env_name
  end

  defp read_token_from_file({ :ok, token }), do: { :ok, token }
  defp read_token_from_file({ :error, _ })   do
    case token_from_env do
      nil   -> { :error, nil   }
      token -> { :ok,    token }
    end
  end

  defp token_path,     do: "#{System.user_home}/#{@file_name}"
  defp token_from_env, do: System.get_env @env_name
end
