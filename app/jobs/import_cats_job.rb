class ImportCatsJob < ApplicationJob
  queue_as :default

  def perform(cat); end
end
