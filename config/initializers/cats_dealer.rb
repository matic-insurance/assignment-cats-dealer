CatsDealerConfig.provider_endpoints = {
  cats_unlimited: ENV["CATS_UNLIMITED_ENDPOINT"] ? ENV["CATS_UNLIMITED_ENDPOINT"] : 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json',
  happy_cats: ENV["HAPPY_CATS_ENDPOINT"] ? ENV["HAPPY_CATS_ENDPOINT"] : 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'
}

CatsDealerConfig.parallel_processes = ENV["DEAL_SEARCH_PROCESSES"] ? ENV["DEAL_SEARCH_PROCESSES"].to_i : 2