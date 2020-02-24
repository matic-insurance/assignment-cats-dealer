module SearchHelper
  def cats_type_options
    SearchForm::CATS_TYPE_OPTIONS.sort.map { |o| map_cats_type_option(o) }
  end

  def user_location_options
    SearchForm::LOCATION_OPTIONS.sort.map { |o| map_user_location_option(o) }
  end

  def map_cats_type_option(option)
    map_locales_value_option('cats_type', option)
  end

  def map_user_location_option(option)
    map_locales_value_option('user_location', option)
  end

  def map_locales_value_option(cats_type, option)
    option_ = option.to_s.parameterize(separator: '_')
    locales_path = "forms.search.elements.#{cats_type}.options.#{option_}"

    [I18n.t(locales_path), option]
  end

  def search_redirection_path(result)
    return search_empty_result_path(result.search_id) if result.items.empty?

    search_result_path(result.search_id)
  end
end
