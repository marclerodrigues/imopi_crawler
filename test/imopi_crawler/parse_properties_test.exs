defmodule ImopiCrawler.ParsePropertiesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock

  alias ImopiCrawler.ParseProperties

  @base_url "http://www.imoveisnopiaui.com/comprar/a-z/?page=1"

  setup_all do
    ExVCR.Config.cassette_library_dir("vcr_cassettes")
    HTTPotion.start
    :ok
  end

  setup do
    use_cassette "get_properties" do
      body = HTTPotion.get(@base_url).body
      [body: parse_body(body)]
    end
  end

  describe "#perform" do
    test "returns a list of Property Struct", context do
      body = context[:body]
      properties = ParseProperties.perform(body)

      only_property? = Enum.map(properties, fn element ->
        element.__struct__ == ImopiCrawler.Property
      end)
      |> Enum.all?(fn x -> x != false end)

      assert only_property? == true
    end

    test "does not contain empty elements", context do
      body = context[:body]
      properties = ParseProperties.perform(body)
      empty = Enum.any?(properties, fn element -> element == "" end)

      assert empty == false
    end

    test "does not cotain properties without price", context do
      body = context[:body]
      properties = ParseProperties.perform(body)
      empty = Enum.any?(properties, fn element -> element.price == "" end)

      assert empty == false
    end
  end

  defp parse_body(body) do
    body |> Floki.parse |> Floki.find(".rock-line div")
  end
end
