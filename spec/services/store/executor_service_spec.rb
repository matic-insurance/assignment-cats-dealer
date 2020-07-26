require 'rails_helper'

describe Store::ExecutorService do
  context 'enabled and disabled providers' do
    let(:cats_unlimited_configuration) do
      {
        enabled: true,
        url: Faker::Internet.url
      }
    end

    let(:happy_cats_configuration) do
      {
        enabled: true,
        url: Faker::Internet.url
      }
    end

    let(:providers_configuration) do
      {
        cats_unlimited: cats_unlimited_configuration,
        happy_cats: happy_cats_configuration,
        new_provider: {
          enabled: false,
          url: Faker::Internet.url
        }
      }
    end

    it 'create thread for each active provider' do
      allow(Rails.configuration.settings)
        .to receive(:fetch)
        .with(:providers)
        .and_return(providers_configuration)

      expect(Store::Providers::CatsUnlimited)
        .to receive(:call).with(configuration: cats_unlimited_configuration)

      expect(Store::Providers::HappyCat)
        .to receive(:call).with(configuration: happy_cats_configuration)

      described_class.call
    end
  end
end
