module JsonHelper
  def json(string, *path)
    parsed = Oj.load(string)
    path.empty? ? parsed : parsed.dig(*path)
  end
end

RSpec.configure do |config|
  config.include JsonHelper, type: :controller
  config.include JsonHelper, type: :request
end
