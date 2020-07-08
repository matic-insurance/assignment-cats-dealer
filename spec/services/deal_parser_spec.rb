require 'rails_helper'

describe DealParser do
  subject(:deal_parser) { DealParser }

  it { is_expected.to respond_to(:parse) }
end