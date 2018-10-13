require 'rails_helper'

describe Cat::Create do
  let(:name) { 'breed name 1' }
  let(:price) { 20 }
  let(:location) { 'Lviv' }
  let(:image) { 'http://some_url.com/image.png' }
  subject { described_class.new({ name: name, price: price, location: location, image: image }) }
  let(:correct_response) { double('response', code: 200) }

  describe '#call' do
    context 'with correct params' do
      it 'calls Cat.find_or_create_by with params' do
        allow(RestClient).to receive(:head).and_return(correct_response)

        expect(Cat).to receive(:find_or_create_by).with({ name: name, price: price, location: location, image: image })

        subject.call
      end
    end

    context 'no image found' do
      it 'calls Cat.find_or_create_by without image' do
        allow(RestClient).to receive(:head).and_raise(RestClient::ExceptionWithResponse)

        expect(Cat).to receive(:find_or_create_by).with({ name: name, price: price, location: location, image: nil })

        subject.call
      end
    end

    context 'with incorrect params' do
      subject { described_class.new({ some_attr: 'test', some_attr2: 'test2', location: location, image: image }) }

      it 'raises no keys exception' do
        expect(Cat).not_to receive(:find_or_create_by)

        expect { subject.call }.to raise_error KeyError
      end
    end
  end
end
