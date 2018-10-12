require 'rails_helper'

describe Content::HappyCats::Adapter do
  let(:create_cat_double) { double 'CreateCatDouble' }
  let(:fetcher) { instance_double("Fetcher", call: content) }

  subject { described_class.new(fetcher: fetcher, creator_instance: create_cat_double) }

  describe '#call' do
    context 'with correct fetched content' do
      let(:content) do
        {
          "cats" => {
            "cat" => [
              {
                'title' => 'some name 1',
                'cost' => '20',
                'location' => 'Lviv',
                'img' => 'some image'
              },
              {
                'title' => 'some name 2',
                'cost' => '200',
                'location' => 'Kiew',
                'img' => 'some image'
              }
            ]
          }
        }
      end

      it 'calls Creator with each content item' do
        expect(create_cat_double).to receive(:new).with({
          name: content["cats"]["cat"][0]['title'],
          location: content["cats"]["cat"][0]['location'],
          price: content["cats"]["cat"][0]['cost'],
          image: content["cats"]["cat"][0]['img']
        }).and_return(double(call: true))

        expect(create_cat_double).to receive(:new).with({
          name: content["cats"]["cat"][1]['title'],
          location: content["cats"]["cat"][1]['location'],
          price: content["cats"]["cat"][1]['cost'],
          image: content["cats"]["cat"][1]['img']
        }).and_return(double(call: true))

        subject.call
      end
    end

    context 'with incorrect fetched content' do
      context 'some incorrect fields inside content elements' do
        let(:content) do
          {
            "cats" => {
              "cat" => [
                {
                  'title' => 'some name 1',
                  'cost' => '20',
                  'blabla' => 'some value',
                  'img' => 'some image'
                },
              ]
            }
          }
        end

        it 'calls Creator with ignoring incorrect fields' do
          expect(create_cat_double).to receive(:new).with({
          name: content["cats"]["cat"][0]['title'],
          location: nil,
          price: content["cats"]["cat"][0]['cost'],
          image: content["cats"]["cat"][0]['img']
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
          expect { subject.call }.to raise_error KeyError
        end
      end
    end
  end
end
