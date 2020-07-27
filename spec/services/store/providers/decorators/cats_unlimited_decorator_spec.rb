require 'rails_helper'
require Rails.root.join('spec', 'services', 'store', 'providers', 'decorators', 'shared_examples.rb')

describe Store::Providers::Decorators::CatsUnlimitedDecorator do
  context 'receive parsed response' do
    let(:parsed_response) do
      [
        {
          'name' => title,
          'price' => price,
          'location' => location,
          'image' => image
        }
      ]
    end

    include_examples :decorators_logic
  end
end
