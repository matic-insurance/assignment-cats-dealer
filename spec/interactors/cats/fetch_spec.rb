require "rails_helper"

RSpec.describe Cats::Fetch do
  it "calls Cats::CatsUnlimitedAdapter" do
    allow(Cats::CatsUnlimitedAdapter).
      to receive(:fetch_items).
      and_return([])
    allow(Cats::HappyCatsAdapter).
      to receive(:fetch_items).
      and_return([])

    described_class.call

    expect(Cats::CatsUnlimitedAdapter).to have_received(:fetch_items)
  end

  it "calls Cats::HappyCatsAdapter" do
    allow(Cats::CatsUnlimitedAdapter).
      to receive(:fetch_items).
      and_return([])
    allow(Cats::HappyCatsAdapter).
      to receive(:fetch_items).
      and_return([])

    described_class.call

    expect(Cats::HappyCatsAdapter).to have_received(:fetch_items)
  end

  context "when adapters response are empty" do
    it "returns empty array" do
      allow(Cats::CatsUnlimitedAdapter).
        to receive(:fetch_items).
        and_return([])
      allow(Cats::HappyCatsAdapter).
        to receive(:fetch_items).
        and_return([])

      result = described_class.call

      expect(result.items).to eq([])
    end
  end

  it "returns merged results from all adapters" do
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
    expected_result = [first_result, second_result]

    allow(Cats::CatsUnlimitedAdapter).
      to receive(:fetch_items).
      and_return([first_result])
    allow(Cats::HappyCatsAdapter).
      to receive(:fetch_items).
      and_return([second_result])

    result = described_class.call

    expect(result.items).to eq(expected_result)
  end
end
