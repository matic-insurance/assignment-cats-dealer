# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseClientService do
  describe '#call' do
    context 'when format_response not implemented' do
      let(:url) { 'www.test-url.com' }

      before do
        stub_const('BaseClientService::URL', url)
        stub_request(:get, url).to_return(status: 200, body: '', headers: {})
      end

      it 'raises an error' do
        expect { described_class.new.call }.to raise_error NotImplementedError
      end
    end
  end
end
