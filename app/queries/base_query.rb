class BaseQuery
  def call
    raise NotImplementedError, "This #{self.class} cannot respond to: #{__method__}"
  end

  def filter_by_attribute(scope, attribute, value)
    return scope unless attribute.present? && value.present?

    scope.select { |record| record[attribute].downcase == value.downcase }
  end
end
