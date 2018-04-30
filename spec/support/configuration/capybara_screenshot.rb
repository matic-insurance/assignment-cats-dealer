# autosave screenshots
Capybara::Screenshot.autosave_on_failure = true

# browser window size for screenshots
Capybara::Screenshot.webkit_options = {width: 1024, height: 768}

# Keep up to the number of screenshots specified in the hash
Capybara::Screenshot.prune_strategy = {keep: 10}

# rendering screenshots
Capybara::Screenshot.register_driver(:poltergeist_desktop) do |driver, path|
  driver.save_screenshot(path)
end

# append a link to screenshot to failed test in RSpec output
Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples = true

# append a screenshot to failed test in RSpec HTML report
Capybara::Screenshot::RSpec::REPORTERS['RSpec::Core::Formatters::HtmlFormatter'] =
  Capybara::Screenshot::RSpec::HtmlEmbedReporter
