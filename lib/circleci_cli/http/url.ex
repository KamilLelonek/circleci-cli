defmodule CircleciCli.HTTP.URL do
  @circleci_endpoint             "https://circleci.com/api/v1"
  @circleci_endpoint_token_query "?circle-token="

  defp build(endpoint, token) do
    "#{@circleci_endpoint}#{endpoint}#{@circleci_endpoint_token_query}#{token}"
  end
end
