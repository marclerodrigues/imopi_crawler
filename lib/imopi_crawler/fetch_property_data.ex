defmodule ImopiCrawler.FetchPropertyData do
  alias ImopiCrawler.Property

  def perform(element) do
    %Property{
      image: fetch_image(element),
      zone: fetch_zone(element),
      price: fetch_price(element),
      rooms: fetch_rooms(element),
      parking_space: fetch_parking_space(element),
      bathrooms: fetch_bathroms(element),
      area: fetch_area(element),
      cost: fetch_cost(element),
      details_url: fetch_details_url(element)
    }
  end

  defp fetch_image(element) do
    Floki.find(element, "img") |> Floki.attribute("src") |> List.first
  end

  defp fetch_zone(element) do
    Floki.find(element, "div.lic-cidzona") |> Floki.text
  end

  defp fetch_price(element) do
    Floki.find(element, "div.lic-preco") |> Floki.text
  end

  defp fetch_rooms(element) do
    Floki.find(element, "div.lic-detalhes span.quarto") |> Floki.text
  end

  defp fetch_parking_space(element) do
    Floki.find(element, "div.lic-detalhes span.garagem") |> Floki.text
  end

  defp fetch_bathroms(element) do
    Floki.find(element, "div.lic-detalhes span.banheiro") |> Floki.text
  end

  defp fetch_area(element) do
    Floki.find(element, "div.lic-detalhes span.area") |> Floki.text
  end

  defp fetch_cost(element) do
    Floki.find(element, "div.lic-custo") |> Floki.text
  end

  defp fetch_details_url(element) do
    Floki.find(element, "div.lic-comprar a")
    |> Floki.attribute("href")
    |> List.first
  end
end
