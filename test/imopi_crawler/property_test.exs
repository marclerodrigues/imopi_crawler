defmodule ImopiCrawler.PropertyTest do
  use ExUnit.Case
  alias ImopiCrawler.Property

  @expected_image "image.jpg"
  @expected_price 1500
  @expected_zone "Great Property Piaui"
  @expected_rooms 2
  @expected_parking_space 1
  @expected_bathrooms 2
  @expected_area 50
  @expected_cost 30

  setup do
    [property: %Property{
      image: "image.jpg",
      price: 1500,
      zone: "Great Property Piaui",
      rooms: 2,
      parking_space: 1,
      bathrooms: 2,
      area: 50,
      cost: 30
    }]
  end

  test "returns the correct image", context do
    assert context[:property].image == @expected_image
  end

  test "returns the correct price", context do
    assert context[:property].price == @expected_price
  end

  test "returns the correct zone", context do
    assert context[:property].zone == @expected_zone
  end

  test "returns the correct numbers of rooms", context do
    assert context[:property].rooms == @expected_rooms
  end

  test "returns the correct numbers of parking spaces", context do
    assert context[:property].parking_space == @expected_parking_space
  end

  test "returns the correct number of bathrooms", context do
    assert context[:property].bathrooms == @expected_bathrooms
  end
end
