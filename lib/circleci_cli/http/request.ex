defmodule CircleciCli.HTTP.Request do
  def send([url: url, method: method]),
  do: send([url: url, method: method, body: ""])

  def send([url: url, method: method, body: body]),
  do: HTTPoison.request(method, url, body)

  def process(response) do
    case response do
      {:ok,    %HTTPoison.Response{status_code: 200, body: body}} -> IO.puts body
      {:ok,    %HTTPoison.Response{status_code: 401}}             -> IO.puts "Given token is invalid!"
      {:ok,    %HTTPoison.Response{status_code: 404}}             -> IO.puts "Requested resource not found!"
      {:error, %HTTPoison.Error{reason: reason}}                  -> IO.inspect reason
    end
  end
end
