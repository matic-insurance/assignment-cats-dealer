require 'rails_helper'

describe Content::CatsUnlimited::Adapter do
  let(:create_cat_double) { double 'CreateCatDouble' }
  let(:fetcher) { instance_double("Fetcher", call: content) }

  subject { described_class.new(fetcher: fetcher, creator_instance: create_cat_double) }

  describe '#call' do
    context 'with correct fetched content' do
      let(:content) do
        [{
          'name' => 'some name 1',
          'price' => '20',
          'location' => 'Lviv',
          'image' => 'some image'
        },
        {
          'name' => 'some name 2',
          'price' => '200',
          'location' => 'Kiew',
          'image' => 'some image'
        }]
      end

      it 'calls Creator with each content item' do
        expect(create_cat_double).to receive(:new).with({
          name: content[0]['name'],
          location: content[0]['location'],
          price: content[0]['price'],
          image: content[0]['image']
        }).and_return(double(call: true))

        expect(create_cat_double).to receive(:new).with({
          name: content[1]['name'],
          location: content[1]['location'],
          price: content[1]['price'],
          image: content[1]['image']
        }).and_return(double(call: true))

        subject.call
      end
    end

    context 'with incorrect fetched content' do
      context 'some incorrect fields inside content elements' do
        let(:content) do
          [{
            'name' => 'some name 1',
            'some_other_value' => '20',
            'location' => 'Lviv',
            'image' => 'some image'
          }]
        end

        it 'calls Creator with ignoring incorrect fields' do
          expect(create_cat_double).to receive(:new).with({
            name: content[0]['name'],
            location: content[0]['location'],
            price: nil,
            image: content[0]['image']
          }).and_return(double(call: true))

          subject.call
        end
      end

      context 'incorrect response' do
        let(:content) do
          {
            'some_other_value' => 'test',
          }
        end

        it 'raises exception' do
          expect { subject.call }.to raise_error TypeError
        end
      end
    end
  end
end
