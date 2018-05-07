class CatsController < ApplicationController
  HAPPY_CATS_FIELDS_MAPPER = {
    title: 'breed',
    cost: 'price',
    img: 'image'
  }.with_indifferent_access

  UNLIMITED_CATS_FIELDS_MAPPER = {
    name: 'breed',
  }.with_indifferent_access

  def search
    threads = []
    threads << Thread.new {
      response = RestClient.get('https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json')
    JSON.parse(response.body).map {
      |cat| cat.map {
        |field, value| [UNLIMITED_CATS_FIELDS_MAPPER[field] || field, value]
      }.to_h
    }.each {|cat| cat['shop'] = 'Cats Unlimited'}}
    threads << Thread.new { response = RestClient.get('https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml')
    Nokogiri::Slop(response.body).cats.cat.map {
      |cat| Hash.from_xml(cat.to_s).with_indifferent_access[:cat].map {
        |field, value| [HAPPY_CATS_FIELDS_MAPPER[field] || field, value]
      }.to_h
    }.each {|cat| cat['shop'] = 'Happy Cats'}}

    results = threads.map(&:join).map(&:value).flatten
    @locations = results.collect {|cat| cat['location']}.compact.uniq
    @breeds = results.collect {|cat| cat['breed']}.uniq
    @cats_list = []

    if params[:location] && params[:breed]
      @cats_list = results.select { |cat| cat['location'] == params[:location] && cat['breed'] ==  params[:breed]}.sort_by{|cat|cat['price'].to_i}
      @location = params[:location]
      @breed = params[:breed]
    end
  end
end
