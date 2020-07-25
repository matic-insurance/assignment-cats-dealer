module Callable
  def call(params = {})
    new(params).perform
  end
end
