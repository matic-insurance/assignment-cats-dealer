require 'rails_helper'

describe 'CatStores' do
  let!(:city_one) { create(:city) }
  let!(:cat_name_one) { create(:cat_name) }
  let!(:city_two) { create(:city) }
  let!(:cat_name_two) { create(:cat_name) }

  before do
    visit root_path
  end

  it 'shows title for cat type' do
    expect(page).to have_text('Select cat type:')
  end

  it 'shows title for location' do
    expect(page).to have_text('Select your location:')
  end

  it 'shows best price' do
    10.times do
      create(:cats_store, location: city_one.location, name: cat_name_one.name)
    end

    page.find('.btn-default').click
    expect(page).to have_text("Best price for your location - #{CatsStore.minimum(:price)}")
    expect(page).to have_text("#{city_one.location}")
    expect(page).to have_text("#{cat_name_one.name}")
    expect(page).to_not have_text("#{city_two.location}")
    expect(page).to_not have_text("#{cat_name_two.name}")
  end
end
