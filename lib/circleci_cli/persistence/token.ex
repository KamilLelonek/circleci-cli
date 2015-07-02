defmodule CircleciCli.Persistence.Token do
  @file_name ".circle_cli_token"
  @env_name  "CIRCLECI_API_TOKEN"

  def  write(token), do: File.write(token_path, token)
  def  read,         do: read_token_from_file File.read(token_path)

  defp read_token_from_file({ :error, _ }) do
    case token_from_env do
      nil   -> { :error, "Neither file nor environmental variable with token was found."}
      token -> { :ok, token}
    end
  end

  defp token_path,                           do: "#{System.user_home}/#{@file_name}"
  defp token_from_env,                       do: System.get_env @env_name
  defp read_token_from_file({ :ok, token }), do: { :ok, token }
end
