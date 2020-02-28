# frozen_string_literal: true

class HappyCatsAdapter < BaseAdapter
  URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'

  def cats
    response = request(URL)
    result   = Hash.from_xml(response.body)['cats']['cat']

    result.map do |res|
      build_cat(res['title'], res['cost'], res['location'], res['img'])
    end
  end
end
