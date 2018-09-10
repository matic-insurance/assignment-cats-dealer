require 'rails_helper'

describe Breed do
  describe 'validations' do
    subject { create :breed }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
