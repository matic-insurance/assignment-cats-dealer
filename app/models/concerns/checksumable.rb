# Provides model with .has_checksum method
#
# Uses Digest::MD5 internally in order to calculate and set checksum based on
# provided method.
#
# Adds uniqueness validation to provided attribute.
#
# Examples:
#
#   # it's going to consider `@foo` as a checksum attr and `#bar` as a value to hash
#   has_checksum :foo, base: :bar
#
# Defaults:
#
#   @checksum - attribute to save checksum to
#   #checksum_base - method to provide base value to md5
#
module Checksumable
  extend ActiveSupport::Concern

  DEFAULT_CHECKSUM_ATTR = :checksum
  DEFAULT_BASE          = :checksum_base

  class_methods do
    def has_checksum(attr = DEFAULT_CHECKSUM_ATTR, options = {})
      base = options[:base] || DEFAULT_BASE

      cattr_accessor :checksum_opts
      self.checksum_opts ||= { attr: attr, base: base }

      validates attr, uniqueness: true
    end
  end

  included do
    before_save do
      self[checksum_opts[:attr]] =
        Digest::MD5.hexdigest(send(checksum_opts[:base]))
    end
  end
end
