defmodule ImopiCrawler do
  alias ImopiCrawler.ParseProperties

  @base_url "http://www.imoveisnopiaui.com/comprar/a-z/"
  @max_retries 10
  @wait_to_fetch_again 1_000
  @starting_list []

  def properties(base_url \\ @base_url, page \\ 1, properties \\ @starting_list) do
    fetch_data(base_url, page, properties) |> ParseProperties.perform
  end

  defp fetch_data(url, page, properties, retries \\ @max_retries)

  defp fetch_data(url, page, properties, 0) do
    raise "Failed to fetch from #{url}?#{page} after #{@max_retries} retries."
  end

  defp fetch_data(url, page, properties, retries) do
    try do
      response = get_response(url, page)
      case response do
        %HTTPotion.Response{body: _, headers: _, status_code: status} when status == 200 ->
          fetch_data(url, page + 1, properties ++ parse_response(response))
        %HTTPotion.Response{ body: _, headers: _, status_code: status } when status > 408 ->
          raise %HTTPotion.HTTPError{message: "req_timedout"}
        _ ->
          properties
      end
    rescue
      error ->
        case error do
          %HTTPotion.HTTPError{message: "req_timedout"} ->
            :timer.sleep(@wait_to_fetch_again)
            fetch_data(url, page, properties, retries - 1)
          %RuntimeError{} ->
            properties
        end
    end
  end

  defp get_response(url, page) do
    "#{url}?page=#{page}" |> URI.encode |> HTTPotion.get
  end

  defp parse_response(response) do
    response.body |> Floki.parse |> Floki.find(".rock-line div")
  end
end
