module Relations
  module CatBreed
    extend ActiveSupport::Concern

    def breed=(breed)
      @breed = breed.is_a?(Breed) ? breed.name : breed
    end

    included do
      belongs_to :breed

      validates :breed, presence: true

      before_validation do
        self.breed_id = Breed.find_or_create_by(name: @breed).id
      end
    end
  end
end
