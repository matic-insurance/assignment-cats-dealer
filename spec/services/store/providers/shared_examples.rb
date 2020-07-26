shared_examples :providers_logic do
  let(:url) { Faker::Internet.url }
  let(:configuration) { { url: url } }

  let(:title) { Faker::String.random(length: 4) }
  let(:price) { Faker::Number.number(digits: 3) }
  let(:location) { Faker::Address.city }
  let(:image) { Faker::Internet.url }

  it 'returns result struct' do
    expect(RestClient)
      .to receive(:get).with(url).and_return(double(body: provider_response))

    result = described_class.(configuration: configuration).first

    expect(result.title).to eq(title)
    expect(result.price).to eq(price)
    expect(result.location).to eq(location)
    expect(result.image).to eq(image)
  end
end
