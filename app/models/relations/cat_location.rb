module Relations
  module CatLocation
    extend ActiveSupport::Concern

    def location=(location)
      @location = location.is_a?(Location) ? location.name : location
    end

    included do
      belongs_to :location

      validates :location, presence: true

      before_validation do
        self.location_id = Location.find_or_create_by(name: @location).id
      end
    end
  end
end
