module BaseService
  def self.included(base)
    base.class_eval do
      extend Callable
    end
  end

  include ResponseStructure
end
