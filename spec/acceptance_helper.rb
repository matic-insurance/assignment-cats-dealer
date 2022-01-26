require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = :html
  config.curl_host = 'http://localhost:3000'
  config.api_name = 'Assignment cats dealer app API'
  config.response_body_formatter = proc do |response_content_type, response_body|
    if response_content_type =~ %r{application/.*json}
      JSON.pretty_generate(JSON.parse(response_body))
    else
      response_body
    end
  end
end

RSpec.configure do |config|
  config.include AcceptanceMacros, api_doc_dsl: :resource
end
