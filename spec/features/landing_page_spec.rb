require 'rails_helper'

RSpec.describe 'Landing page' do
  before do
    create_list(:cat, 10)
    create(:cat, :purebred, price: 100)
    create(:cat, :purebred, price: 300)

    visit '/'
  end

  specify 'application name is displayed in header' do
    within('.navbar .navbar-brand') do
      expect(page).to have_content(I18n.t('application.header.title'))
    end
  end

  specify 'cat logo is visible in header' do
    within('.navbar') do
      expect(page).to have_css('.logo')
    end
  end

  specify 'cats finder form is visible' do
    within('.app-main') do
      expect(page).to have_content(I18n.t('requests.new.header'))
      expect(page).to have_css('form')
    end
  end

  specify 'user can select desired cat breed' do
    within('.app-main form') do
      expect(page).to have_content(I18n.t('requests.new.select_type'))
      expect(page).to have_css('#breedTypeSelector')
    end
  end

  specify 'user can select desired cat location' do
    within('.app-main form') do
      expect(page).to have_content(I18n.t('requests.new.select_location'))
      expect(page).to have_css('#locationSelector')
    end
  end

  specify 'user is able to find best cat offer using both form selectors' do
    select_cat_breed('Pedigree')
    select_cat_location('Lviv')
    submit_search_form

    min_price_label = I18n.t('requests.result.best_price_label')
    expect(page).to have_content("#{min_price_label} 100")
    expect(page).to have_css('.cat', count: 2)
  end

  specify 'user is able to find best cat offer using only location' do
    select_cat_location('Lviv')
    submit_search_form
    expect(page).to have_css('.cat', count: 12)
  end

  specify 'user is able to find best cat offer using only type' do
    select_cat_breed('Typical')
    submit_search_form
    expect(page).to have_css('.cat', count: 10)
  end
end
