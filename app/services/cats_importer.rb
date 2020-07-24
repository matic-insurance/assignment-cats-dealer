module CatsImporter
  def self.execute(provider)
    raw_deals = DealParser.parse(provider)
    FieldMapings.apply_field_mappings!(raw_deals)
  end
end