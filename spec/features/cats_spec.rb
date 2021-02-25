describe 'Cat best offer', type: :feature do
  vcr_options = { cassette_name: 'data/all_cats' }

  context 'when cat is found', vcr: vcr_options do
    before do
      visit '/'

      select 'Abyssin', from: 'name'
      select 'Lviv', from: 'location'
      click_button 'Send request'
    end

    it 'returns best price to buy a cat' do
      expect(page).to have_selector('#best_price')
    end

    it 'returns table with all matching cats' do
      expect(page).to have_selector('#filtered_cats')
    end

    it 'does not return error message' do
      expect(page).not_to have_selector('#error_message')
    end
  end

  context 'when cat is not found', vcr: vcr_options do
    before do
      visit '/'

      select 'Persian', from: 'name'
      select 'Lviv', from: 'location'
      click_button 'Send request'
    end

    it 'returns error message' do
      expect(page).to have_selector('#error_message')
    end

    it 'does not return best price to buy a cat' do
      expect(page).not_to have_selector('#best_price')
    end

    it 'does not return table with all matching cats' do
      expect(page).not_to have_selector('#filtered_cats')
    end
  end
end
