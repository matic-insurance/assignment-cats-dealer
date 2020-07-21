class Cat < ApplicationRecord
  belongs_to :provider, optional: true
end
