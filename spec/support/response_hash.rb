module ResponseHash
  extend RSpec::SharedContext

  let(:response_hash) { JSON.parse(response.body) }
end

RSpec.configure do |config|
  config.include ResponseHash
end
