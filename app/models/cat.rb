class Cat < ApplicationRecord
  ALL_RECORDS = 'All'

  def self.filter(options)
    where(options.reject! { |_, value| value.nil? || value == ALL_RECORDS}).order(:price)
  end
end
