require 'rails_helper'

RSpec.describe 'Root path', type: :routing do
  it 'should route to items_controller#show' do
    expect(get('/')).to route_to('items#show')
  end
end
