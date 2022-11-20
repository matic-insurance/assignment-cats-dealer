# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CatsFetchService do
  describe '#call' do
    subject(:cats_list) { described_class.call }

    let(:happy_cats_url) { 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml' }
    let(:cats_unlimited_url) { 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json' }

    before do
      stub_request(:get, cats_unlimited_url)
        .to_return(
          status: status_response,
          body: unlimited_cats_response_body,
          headers: { content_type: 'application/json' }
        )

      stub_request(:get, happy_cats_url)
        .to_return(
          status: status_response,
          body: happy_cats_response_body,
          headers: { content_type: 'application/xml' }
        )
    end

    context 'when clients responses successful' do
      let(:status_response) { 200 }
      let(:unlimited_cats_response_body) do
        {
          name: 'Abyssin',
          price: 500,
          location: 'Lviv',
          image: 'https://olxua-ring02/1.png'
        }.to_json
      end

      let(:happy_cats_response_body) do
        {
          cat: [
            {
              title: 'American Curl',
              cost: '650',
              location: 'Odessa',
              img: 'https://pic.photos/200'
            }
          ]
        }.to_xml(root: 'cats')
      end

      it { is_expected.to be_kind_of(Array) }
      it { expect(cats_list.first).to be_kind_of(Cat) }
    end

    context 'when clients responses not successful' do
      let(:unlimited_cats_response_body) { '' }
      let(:happy_cats_response_body) { '' }
      let(:status_response) { 400 }

      it { is_expected.to be_empty }
    end
  end
end
