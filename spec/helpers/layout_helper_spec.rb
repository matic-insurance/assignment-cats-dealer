require 'rails_helper'

describe LayoutHelper, type: :helper do
  describe '#try_render' do
    it { expect(helper.try_render('invalid')).to be_nil }
  end
end
