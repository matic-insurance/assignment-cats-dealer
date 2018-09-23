require 'rails_helper'

RSpec.feature 'Requests', type: :feature do
  it 'display requests form' do
    visit '/'

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Select cat breed')
    expect(page).to have_content('Select your location')
    expect(page).to have_selector(:link_or_button, 'Send request')
  end
end
