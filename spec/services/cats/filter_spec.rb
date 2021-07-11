require "rails_helper"

RSpec.describe Cats::Filter do
  it "calls Cats::Fetch" do
    fetch_instance = stub_fetch_service

    described_class.new.call

    expect(fetch_instance).to have_received(:call)
  end

  context "when Cats::Fetch returns empty response" do
    it "returns empty array" do
      stub_fetch_service

      result = described_class.new.call

      expect(result).to eq([])
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

      stub_fetch_service(result: expected_result)

      result = described_class.new.call

      expect(result).to eq(expected_result)
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
      fetch_service_result = [first_result, second_result, third_result]

      stub_fetch_service(result: fetch_service_result)

      result = described_class.new(breed: "Grumpy").call

      expect(result).to eq(expected_result)
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

      fetch_service_result = [first_result, second_result, third_result]

      stub_fetch_service(result: fetch_service_result)

      result = described_class.new(location: "Kyiv").call

      expect(result).to eq(expected_result)
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

      fetch_service_result = [first_result, second_result, third_result]

      stub_fetch_service(result: fetch_service_result)

      result = described_class.new(breed: "Cutie", location: "Lviv").call

      expect(result).to eq(expected_result)
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

      fetch_service_result = [first_result, second_result, third_result]

      stub_fetch_service(result: fetch_service_result)

      result = described_class.new(breed: "Cutie", location: "Lviv").call

      expect(result).to eq(expected_result)
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

      fetch_service_result = [first_result, second_result, third_result]

      stub_fetch_service(result: fetch_service_result)

      result = described_class.new(breed: "cutie", location: "lviv").call

      expect(result).to eq(expected_result)
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

      fetch_service_result = [first_result, second_result, third_result]

      stub_fetch_service(result: fetch_service_result)


      result = described_class.new(breed: "Cutie", location: "Lviv").call

      expect(result).to eq(expected_result)
    end
  end

  def stub_fetch_service(result: [])
    fetch_instance = instance_double("Cats::Fetch", call: result)
    allow(Cats::Fetch).
      to receive(:new).
      and_return(fetch_instance)
    fetch_instance
  end
end
