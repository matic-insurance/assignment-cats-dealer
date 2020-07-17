class ImportCatsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Rails.logger.info("import cats")
  end
end
