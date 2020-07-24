module CatsProviders
  module DealerConfigs
    def endpoint
      CatsDealerConfig.provider_endpoints[self.class.name.split('::').last.underscore.to_sym]
    end
  end
end