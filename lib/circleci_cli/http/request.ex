defmodule CircleciCli.HTTP.Request do
  def send([url: url, method: method, body: body]),
  do: HTTPoison.request(method, url, body)
end
