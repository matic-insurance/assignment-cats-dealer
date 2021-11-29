# frozen_string_literal: true

class BaseService
  def self.call(*args, &block)
    new.call(*args, &block)
  end
end
