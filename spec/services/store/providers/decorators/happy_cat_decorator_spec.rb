require 'rails_helper'
require Rails.root.join('spec', 'services', 'store', 'providers', 'decorators', 'shared_examples.rb')

describe Store::Providers::Decorators::HappyCatDecorator do
  context 'receive parsed response' do
    let(:parsed_response) do
      {
        cats: {
          cat: [
            title: title,
            cost: price,
            location: location,
            img: image
          ]
        }
      }
    end

    include_examples :decorators_logic
  end
end
