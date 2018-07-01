# Module for an predicates
module Predicate
  # Predicate class for an cats responses
  class Cats
    def initialize(data)
      @data = data
    end

    # Returns an array based on location and cat type
    # Also we have the two base response formats.
    # If we retrieve json format, we selecting
    # based on `location` and `name` keys
    # Otherwise on `location` and `title`
    def exclude_from(format, location, type)
      if format == :json
        return @data.select{ |cat| cat['location'] == location && cat['name'] == type }
      end
      @data.select { |cat| cat['location'] == location && cat['title'] == type }
    end

    # Returns an array based on JSON format
    def json_result(location, type)
      exclude_from :json, location, type
    end

    # Returns an array based on XML format
    def xml_response(location, type)
      exclude_from :xml, location, type
    end

    # Returns an array based on JSON and XML responses
    def result_by(location, type)
      json_result(location, type) + xml_response(location, type)
    end
  end
end
