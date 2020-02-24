class SearchService
  def initialize(search_params: {}, search_id: nil)
    @search_params = search_params
    @search_id = search_id
    @search_struct = Struct.new(:search_id, :items)
  end

  def perform
    items = ShopsConsolidatorService.new(search_params).items
    SearchCacheService.new(search_id).write(items)

    search_result(items)
  end

  def result
    cached_items = SearchCacheService.new(search_id).read
    search_result(cached_items)
  end

  private

  attr_reader :search_params, :search_struct

  def search_id
    @search_id ||= SecureRandom.uuid
  end

  def search_result(items)
    search_struct.new(search_id, Array.wrap(items))
  end
end
