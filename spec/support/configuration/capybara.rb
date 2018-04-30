DESKTOP_USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2)'\
' AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9'.freeze

# register driver with user agent for js-tests
Capybara.register_driver :poltergeist_desktop do |app|
  config = Capybara::Poltergeist::Driver.new(app, js_errors: true, inspector: true, timeout: 30)
  config.headers = {'User-Agent' => DESKTOP_USER_AGENT}
  config
end

Capybara.register_driver :rack_test_desktop do |app|
  Capybara::RackTest::Driver.new(app, headers: {'HTTP_USER_AGENT' => DESKTOP_USER_AGENT})
end

Capybara.configure do |config|
  config.ignore_hidden_elements = true

  config.default_driver    = :rack_test_desktop
  config.javascript_driver = :poltergeist_desktop
end
