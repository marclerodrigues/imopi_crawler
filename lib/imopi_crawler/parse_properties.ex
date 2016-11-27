defmodule ImopiCrawler.ParseProperties do
  alias ImopiCrawler.FetchPropertyData

  def perform(properties) do
    properties
    |> Enum.map(fn element ->
      FetchPropertyData.perform(element)
    end)
    |> filter_properties
  end

  defp filter_properties(properties) do
    properties
    # Remove empty elements
    |> Enum.filter(fn property ->
      property != ""
    end)
    # Remove properties without a details page
    |> Enum.filter(fn property ->
      property.details_url != nil
    end)
    # Remove properties which don't contain price info
    |> Enum.filter(fn property ->
      property.price != ""
    end)
  end
end
