# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Cats search flow' do
  subject        { page }
  let(:cassette) { 'shops_api' }

  around(:each) do |example|
    VCR.use_cassette(cassette, &example)
  end

  before do
    visit root_path

    expect(page).to have_select(:breed)
    expect(page).to have_select(:location)

    select breed,    from: :breed
    select location, from: :location

    click_on 'Seach kitty'

    expect(page).to have_current_path("/request?breed=#{breed}&location=#{location}")
  end

  context 'when searched cat available' do
    let(:breed)    { 'Abyssin' }
    let(:location) { 'Lviv' }

    scenario 'renders the list of matheched cats and minimal price' do
      expect(page).to have_content('Best price for your location - 500')

      expect(page).to have_css 'table'

      within 'table' do
        expect(page).to have_content(500)
        expect(page).to have_content(550)

        expect(page).to have_content(breed).at_least(2)
        expect(page).to have_content(location).at_least(2)
      end
    end
  end

  context 'when searched cat not available' do
    let(:breed)    { 'Bengal' }
    let(:location) { 'Lviv' }

    scenario 'renders the page with error message' do
      expect(page).to have_content('Sorry, no cats for your location :(')
    end
  end
end
