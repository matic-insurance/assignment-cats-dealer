require 'rails_helper'
require 'providers/adapters/base'
require 'providers/clients/base'
require 'providers/models/kitty_shop'
require 'providers/models/base_cat'

describe Providers::Adapters::Base do
  subject(:base_adapter) { described_class.new }

  context 'as implemented methods' do
    let(:generic_client_response) do
      [
        {
          title: 'Juicy',
          cost: 600,
          location: 'Lviv',
          img: 'https://external-rosurce.com/'
        }, {
          title: 'Abyssin',
          cost: 400,
          location: 'Odesa',
          img: 'https://external-rosurce.com/'
        }
      ]
    end

    let(:dummy_client) { double(Providers::Clients::Base, get: generic_client_response) }

    describe '#fetch_all' do
      before do
        allow(base_adapter).to receive(:client).and_return(dummy_client)
        allow(base_adapter).to receive(:wrap).with(generic_client_response).and_return([])
      end

      it 'fetches and wrap cats from provider' do
        expect(base_adapter.fetch_all).to match([])
        expect(base_adapter).to have_received(:client)
        expect(base_adapter).to have_received(:wrap)
      end
    end

    describe '#wrap' do
      let(:base_cat_child) { Providers::Models::KittyShop }
      before { allow(base_adapter).to receive(:base_model).and_return(base_cat_child).exactly(2).times }

      it 'takes parsed response and wraps it into BaseCat models' do
        wrapped_models = base_adapter.send(:wrap, generic_client_response)
        expect(wrapped_models).to be_an(Array)
        expect(wrapped_models.sample).to be_a_kind_of(Providers::Models::BaseCat)
        expect(wrapped_models.count).to be(generic_client_response.size)
      end
    end
  end

  context 'as not implemented methods' do
    describe '#client' do
      it 'is abstract and fails with error when called' do
        expect { base_adapter.send(:client) }.to raise_error(NotImplementedError)
      end
    end

    describe '#base_model' do
      it 'is abstract and fails with error when called' do
        expect { base_adapter.send(:base_model) }.to raise_error(NotImplementedError)
      end
    end
  end
end
