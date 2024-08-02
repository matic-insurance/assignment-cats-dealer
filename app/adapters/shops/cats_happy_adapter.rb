module Shops
  class CatsHappyAdapter < CatAdapter
    private

    def mapping
      {
        name: :title,
        price: :cost,
        location: :location,
        image: :img
      }
    end
  end
end
