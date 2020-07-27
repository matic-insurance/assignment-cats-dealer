shared_examples :decorators_logic do
  let(:title) { Faker::String.random(length: 4) }
  let(:price) { Faker::Number.number(digits: 3) }
  let(:location) { Faker::Address.city }
  let(:image) { Faker::Internet.url }

  subject { described_class.new(parsed_response).decorate.first }

  it 'returns result struct' do
    expect(subject.title).to eq(title)
    expect(subject.price).to eq(price)
    expect(subject.location).to eq(location)
    expect(subject.image).to eq(image)
  end
end
