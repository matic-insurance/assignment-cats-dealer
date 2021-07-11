require "rails_helper"

RSpec.describe Cats::Filter do
  context "when no items to filter" do
    it "returns empty array" do
      result = described_class.call(items: [])

      expect(result.items).to eq([])
    end
  end

  context "when no params provided" do
    it "returns all items" do
      expected_result = [
        {
          location: "Kyiv",
          breed: "Grumpy",
          price: 500,
        },
        second_result = {
          location:  "Lviv",
          breed: "Cutie",
          price: 650,
        },
      ]

      result = described_class.call(items: expected_result)

      expect(result.items).to eq(expected_result)
    end
  end

  context "when breed param provided" do
    it "filters result by breed" do
      first_result = {
        location: "Kyiv",
        breed: "Grumpy",
        price: 500,
      }
      second_result = {
        location: "Lviv",
        breed: "Cutie",
        price: 650,
      }
      third_result = {
        location: "Kharkiv",
        breed: "Grumpy",
        price: 550,
      }
      expected_result = [first_result, third_result]
      all_items = [first_result, second_result, third_result]

      result = described_class.call(breed: "Grumpy", items: all_items)

      expect(result.items).to eq(expected_result)
    end
  end

  context "when location param provided" do
    it "filters result by location" do
      first_result = {
        location: "Kyiv",
        breed: "Grumpy",
        price: 500,
      }
      second_result = {
        location: "Lviv",
        breed: "Cutie",
        price: 650,
      }
      third_result = {
        location: "Kyiv",
        breed: "Siamese",
        price: 550,
      }
      expected_result = [first_result, third_result]

      all_items = [first_result, second_result, third_result]

      result = described_class.call(location: "Kyiv", items: all_items)

      expect(result.items).to eq(expected_result)
    end
  end

  context "when location and breed params provided" do
    it "filters result by params" do
      first_result = {
        location: "Kyiv",
        breed: "Grumpy",
        price: 500,
      }
      second_result = {
        location: "Lviv",
        breed: "Cutie",
        price: 650,
      }
      third_result = {
        location: "Kyiv",
        breed: "Siamese",
        price: 550,
      }
      expected_result = [second_result]

      all_items = [first_result, second_result, third_result]

      result = described_class.call(breed: "Cutie", location: "Lviv", items: all_items)

      expect(result.items).to eq(expected_result)
    end

    it "sorts results by price" do
      first_result = {
        location: "Lviv",
        breed: "Cutie",
        price: 700,
      }
      second_result = {
        location: "Lviv",
        breed: "Cutie",
        price: 650,
      }
      third_result = {
        location: "Lviv",
        breed: "Cutie",
        price: 550,
      }
      expected_result = [third_result, second_result, first_result]

      all_items = [first_result, second_result, third_result]

      result = described_class.call(breed: "Cutie", location: "Lviv", items: all_items)

      expect(result.items).to eq(expected_result)
    end
  end

  context "when location and breed params provided in downcase" do
    it "filters result by params" do
      first_result = {
        location: "Kyiv",
        breed: "Grumpy",
        price: 500,
      }
      second_result = {
        location: "Lviv",
        breed: "Cutie",
        price: 650,
      }
      third_result = {
        location: "Kyiv",
        breed: "Siamese",
        price: 550,
      }
      expected_result = [second_result]

      all_items = [first_result, second_result, third_result]

      result = described_class.call(breed: "cutie", location: "lviv", items: all_items)

      expect(result.items).to eq(expected_result)
    end
  end

  context "when api responds in downcase" do
    it "filters result by params" do
      first_result = {
        location: "kyiv",
        breed: "grumpy",
        price: 500,
      }
      second_result = {
        location: "lviv",
        breed: "cutie",
        price: 650,
      }
      third_result = {
        location: "kyiv",
        breed: "siamese",
        price: 550,
      }
      expected_result = [second_result]

      all_items = [first_result, second_result, third_result]

      result = described_class.call(breed: "Cutie", location: "Lviv", items: all_items)

      expect(result.items).to eq(expected_result)
    end
  end
end
