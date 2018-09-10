class CatsGrid < BaseGrid
  scope do
    Cat.includes(:location, :breed).order(cost: :asc)
  end

  filter(:breed,    :enum, select: proc { dropdown_values_for(Breed) })
  filter(:location, :enum, select: proc { dropdown_values_for(Location) })

  column(:breed)    { |cat| cat.breed.name }
  column(:location) { |cat| cat.location.name }
  column(:cost)
  column(:image) do |cat|
    format(cat.image) do |image|
      content_tag :img, '', src: image, height: '42', width: '42'
    end
  end

  def self.dropdown_values_for(klass)
    klass.pluck(:name, :id)
  end
  private_class_method :dropdown_values_for
end
