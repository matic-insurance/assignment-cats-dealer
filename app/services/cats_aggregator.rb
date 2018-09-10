class CatsAggregator
  SOURCES = [Sources::CatsUnlimited, Sources::HappyCats].freeze

  def call
    SOURCES.each do |source|
      source.new.data.each do |cat|
        next unless save_cat(cat)
      end
    end
  end

  private

  def save_cat(cat)
    cat.save
  rescue ActiveRecord::RecordNotUnique
    log_existing_cat(cat)
    false
  end

  def log_existing_cat(cat)
    Rails.logger.info("Attempted to save existing cat:
      location = #{cat.location.name}
      breed    = #{cat.breed.name}
      checksum = #{cat.checksum}\n"
     )
  end
end
