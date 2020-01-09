class Shop < ApplicationRecord
  default_scope { where(active: true) }
end
