defmodule CircleciCli.Persistence.Token do
  @file_name ".circle_cli_token"

  defp full_path, do: "#{System.user_home}/#{@file_name}"

  def write(token) do
    File.write full_path, token
  end

  def read do
    File.read full_path
  end
end
