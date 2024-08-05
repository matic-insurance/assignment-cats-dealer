# frozen_string_literal: true

class LibLoader
  def self.load
    Dir[Rails.root.join('lib/**/*.rb').to_s].sort.each do |file|
      require file
    end
  end
end
