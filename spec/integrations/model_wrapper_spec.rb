require 'rails_helper'
require 'integrations/wrappers/model_wrapper'

describe ModelWrapper do

  it 'should enrich given hash with shop name' do
    model = spy(Cat)
    initials = :params
    wrapper = ModelWrapper.new(model)
    wrapper.wrap(initials)
    expect(model).to have_received(:new).with(:params).once
  end
end
