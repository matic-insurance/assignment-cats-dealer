module Cats
  module CatHelper
    def cat_breeds
      %w(Abyssin American\ Curl Bengal Bobtail British\ Shorthair Devon\ Rex Grumpy Maine\ Coon Persian Siamese Sphynx).map { |breed| [breed, breed] }
    end

    def cities
      %w(Kharkiv Kyiv Lviv Odessa).map { |city| [city, city] }
    end
  end
end
