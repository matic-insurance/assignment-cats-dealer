require 'simplecov'

SimpleCov.start 'rails' do
  add_group 'Services', 'app/services'

  minimum_coverage 80

  add_filter ['config', 'spec', 'app/channels']
end
