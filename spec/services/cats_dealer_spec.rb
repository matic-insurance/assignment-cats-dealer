require 'rails_helper'

describe CatsDealer do
  it { is_expected.to respond_to(:search) }
  it { is_expected.to respond_to(:best_deal) }
end
