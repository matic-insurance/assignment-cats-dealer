module HappyCatsParser
  def self.parse(response)
    Nokogiri::Slop(response.body).cats.cat.map do |cat|
      Hash.from_xml(cat.to_s).with_indifferent_access[:cat]
    end
  end
end
