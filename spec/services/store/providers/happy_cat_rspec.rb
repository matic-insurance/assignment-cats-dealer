require 'rails_helper'
require Rails.root.join('spec', 'services', 'store', 'providers', 'shared_examples.rb')

describe Store::Providers::HappyCat do
  context 'receive configuration' do
    let(:provider_response) do
      result = {}
      result.compare_by_identity

      result['cat'] = {
        title: title,
        cost: price,
        location: location,
        img: image
      }

      result['cat'] = {
        title: title,
        cost: price,
        location: Faker::Address.city,
        img: Faker::Internet.url
      }

      result.to_xml(skip_types: true, skip_instruct: true, root: :cats)
    end

    include_examples :providers_logic
  end
end
