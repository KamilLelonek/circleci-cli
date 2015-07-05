defmodule CircleciCli.HTTP.Request do
  @headers [{:Accept, "application/json"}]

  def send([url: url, method: method]),
  do: send([url: url, method: method, body: ""])

  def send([url: url, method: method, body: body]),
  do: HTTPoison.request(method, url, body, @headers)

  def process({:ok, %HTTPoison.Response{status_code: 200, body: body}}),
  do: body |> JSX.prettify! |> IO.puts

  def process({:ok,%HTTPoison.Response{status_code: 401}}),
  do: IO.puts "Given token is invalid!"

  def process({:ok,%HTTPoison.Response{status_code: 404}}),
  do: IO.puts "Requested resource not found!"

  def process({:error, %HTTPoison.Error{reason: reason}}),
  do: IO.inspect reason
end
