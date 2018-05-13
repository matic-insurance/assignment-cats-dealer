class ModelWrapper
  def initialize(model)
    @model = model
  end

  def wrap(product)
    @model.new(product)
  end
end