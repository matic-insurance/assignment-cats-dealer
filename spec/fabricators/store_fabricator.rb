Fabricator(:store) do
  name          { Faker::Company.name }
  api_endpoint  { Faker::Internet.url }
  uuid          { Nanoid.generate }
  active        { true }
  currency      { 'uah' }
  mapping       { '' }
end

Fabricator(:store_with_json_response, from: :store) do
  response_type { 'json' }
end

Fabricator(:store_with_xml_response, from: :store) do
  response_type { 'xml' }
end
