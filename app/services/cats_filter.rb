class CatsFilter
  def call(cats, location: nil, breed: nil)
    cats = cats.select { |cat| cat[:location].downcase == location.downcase.strip } if location.present?
    cats = cats.select { |cat| cat[:breed].downcase == breed.downcase.strip } if breed.present?
    cats
  end
end
