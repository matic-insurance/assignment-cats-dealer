require 'rails_helper'

describe CatsProviders do
  it 'has default providers constant' do
    described_class.const_defined?(:DEFAULT_PROVIDERS)
  end
end
