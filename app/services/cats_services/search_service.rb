module CatsServices
  class SearchService
    class << self
      def find_by(params)
        Cat.where(params)
      end
    end
  end
end
