class Cat < ApplicationRecord
  def self.filter(options, skip_filter_value)
    where(options.reject! { |_, value| value.nil? || value == skip_filter_value })
      .order(:price)
  end
end
