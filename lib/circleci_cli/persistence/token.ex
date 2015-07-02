defmodule CircleciCli.Persistence.Token do
  @file_name ".circle_cli_token"
  @env_name  "CIRCLECI_API_TOKEN"

  defp full_path, do: "#{System.user_home}/#{@file_name}"

  def write(token), do: File.write(full_path, token)
  def read,         do: read_token_from_file File.read(full_path)

  defp read_token_from_file({ :error, _ }) do
    case token_from_env do
      nil   -> { :error, "Neither file nor environmental variable with token was found."}
      token -> { :ok, token}
    end
  end

  defp read_token_from_file({ :ok, token }), do: { :ok, token }
  defp token_from_env,                       do: System.get_env @env_name
end
