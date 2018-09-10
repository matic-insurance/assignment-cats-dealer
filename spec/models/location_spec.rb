require 'rails_helper'

describe Location do
  describe 'validations' do
    subject { create :location }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
