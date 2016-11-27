defmodule ImopiCrawler.FetchPropertyDataTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock

  alias ImopiCrawler.FetchPropertyData
  alias ImopiCrawler.Property

  @base_url "http://www.imoveisnopiaui.com/comprar/a-z/?page=1"

  @expected_image "/media/images/SAM_4361_1672.JPG.300x203_q85_crop-smart_watermark-thumb.png"
  @expected_price "R$  265.000,00"
  @expected_rooms "3"
  @expected_zone " CondomÃ­nio Monte Bellos \nCondomÃ­nio de Casas - Centro - Caxias"
  @expected_area "225"
  @expected_bathrooms "2"
  @expected_cost "Custo por mÂ²: R$ 1.177,78"
  @expected_details_url "/caxias/condominio-casa-condominio-monte-bellos/"
  @expected_parking_space "2"

  @expected_property %Property{
    image: @expected_image,
    price: @expected_price,
    rooms: @expected_rooms,
    zone: @expected_zone,
    area: @expected_area,
    bathrooms: @expected_bathrooms,
    cost: @expected_cost,
    details_url: @expected_details_url,
    parking_space: @expected_parking_space

  }

  setup_all do
    ExVCR.Config.cassette_library_dir("vcr_cassettes")
    HTTPotion.start
    :ok
  end

  setup do
    use_cassette "get_properties" do
      body = HTTPotion.get(@base_url).body
      property = parse_body(body)
      [property: List.first property]
    end
  end

  describe "#perform" do
    test "returns a struct of Property", context do
      fetched_info = FetchPropertyData.perform(context[:property])
      assert fetched_info.__struct__ == Property
    end

    test "returns the correct property", context do
      fetched_info = FetchPropertyData.perform(context[:property])
      assert fetched_info == @expected_property
    end
  end

  defp parse_body(body) do
    body |> Floki.parse |> Floki.find(".rock-line div")
  end
end
