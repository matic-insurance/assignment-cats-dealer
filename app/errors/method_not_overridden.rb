# frozen_string_literal: true

class MethodNotOverridden < StandardError
  def initialize
    super('Method is not overridden')
  end
end
