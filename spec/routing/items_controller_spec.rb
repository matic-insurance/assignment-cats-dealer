require 'rails_helper'

RSpec.describe 'Root path', type: :routing do
  it 'should route to items_controller#show' do
    VCR.use_cassette("cats_empty") do
      expect(get('/')).to route_to('items#index')
    end
  end
end
