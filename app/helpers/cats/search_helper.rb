module Cats
  module SearchHelper
    def picture_for(cat)
      image_tag(cat.picture_url, alt: 'Cat Picture', class: 'img-thumbnail')
    end

    def available_locations
      Cat.locations
    end

    def available_breeds
      Cat.breeds
    end
  end
end
