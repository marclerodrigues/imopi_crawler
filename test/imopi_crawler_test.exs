defmodule ImopiCrawlerTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock

  setup_all do
    ExVCR.Config.cassette_library_dir("vcr_cassettes")
    HTTPotion.start
    :ok
  end

  describe "#property" do
    @tag timeout: 70_000
    test "returns all properties" do
      use_cassette "get_all_properties", match_requests_on: [:query] do
        properties = ImopiCrawler.properties
        assert length(properties) == 652
      end
    end
  end
end
