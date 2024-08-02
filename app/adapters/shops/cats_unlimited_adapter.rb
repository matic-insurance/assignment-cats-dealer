module Shops
  class CatsUnlimitedAdapter < CatAdapter
    private

    def mapping
      {
        name: :name,
        price: :price,
        location: :location,
        image: :image
      }
    end
  end
end
