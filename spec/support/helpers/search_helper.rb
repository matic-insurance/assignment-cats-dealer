module SearchHelper
  def select_cat_breed(breed)
    within('form') do
      select_option('#breedTypeSelector', breed)
    end
  end

  def select_cat_location(location)
    within('form') do
      select_option('#locationSelector', location)
    end
  end

  def submit_search_form
    find('input.btn-primary').click
  end

  def select_option(css_selector, value)
    find(:css, css_selector).find(:option, value).select_option
  end
end

RSpec.configure do |config|
  config.include SearchHelper, type: :feature
end
