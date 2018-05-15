require 'rails_helper'
require 'integrations/wrappers/model_wrapper'

describe ModelWrapper do
  it 'enriches given hash with shop name' do
    model = spy(Cat)
    initials = :params
    wrapper = described_class.new(model)
    wrapper.wrap(initials)
    expect(model).to have_received(:new).with(:params).once
  end
end
