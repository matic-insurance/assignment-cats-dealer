require "#{Rails.root}/lib/store_fetch_logic_json"
require "#{Rails.root}/lib/store_fetch_logic_xml"

class StoreFetchLogic
  class << self
    def perform
      stores_config = load_store_config_file
      result = []
      stores_config.each do |_, v|
        response = RestClient.get(v['url'])

        if v['format'] == 'json'
          result += normalize_if_needed(StoreFetchLogicJson.new(response.body, v['path']).parse,
                                        v['keys'])
        else
          result += normalize_if_needed(StoreFetchLogicXml.new(response.body, v['path']).parse,
                                        v['keys'])
        end
      end

      update_cites_and_names(result)
      CatsStore.create(result)
    end

    def load_store_config_file
      YAML.load_file("#{Rails.root}/config/stores.yml")
    end

    def normalize_if_needed(data, keys)
      return data if (data.first.keys - keys.values).blank?

      res = data.map do |item|
        new_item = {}
        item.each do |k, _|
          new_item[keys[k]] = item[k]
        end
        new_item
      end
      res
    end

    def update_cites_and_names(result)
      cities = []
      names = []

      result.each do |item|
        cities << {location: item['location']}
        names << {name: item['name']}
      end

      City.create(cities.uniq! { |e| e[:location] })
      CatName.create(names.uniq! { |e| e[:name] })
    end
  end
end
