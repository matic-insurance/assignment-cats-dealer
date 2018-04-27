namespace :cats do
  namespace :storage do
    desc 'Refreshes storage with new cat offers'
    task refresh: :environment do
      logger = Logger.new(File.join(Rails.root, 'log', 'tasks.log'))

      begin
        logger.info('[Cats Storage] - Starting fetch of new cat offers')
        number_of_new_ofers = CatsStorageRefresherJob.new.perform
        logger.info("[Cats Storage] - Updated storage with #{number_of_new_ofers} new offers")
      rescue StandardError => e
        logger.fatal "[Cats Storage] - Update has failed: #{e.message}"
      end
    end
  end
end
