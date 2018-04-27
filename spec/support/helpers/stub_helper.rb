module Support
  module Helpers
    module StubHelper
      def stub_env(key_or_hash, value = nil)
        init_stub unless env_stubbed?

        if key_or_hash.is_a? Hash
          key_or_hash.each { |k, v| add_stubbed_value(k, v) }
        else
          add_stubbed_value key_or_hash, value
        end
      end

      def without_env(key)
        original_value = ENV[key]
        remove_stubbed_value(key)
        yield
      ensure
        stub_env(key, original_value)
      end

      private

      STUBBED_KEY = '__STUBBED__'.freeze

      def add_stubbed_value(key, value)
        allow(ENV).to receive(:[]).with(key).and_return(value)
        allow(ENV).to receive(:fetch).with(key).and_return(value)
        allow(ENV).to receive(:fetch).with(key, anything) do |_, default_value|
          value || default_value
        end
      end

      def remove_stubbed_value(key)
        allow(ENV).to receive(:[]).with(key).and_call_original
        allow(ENV).to receive(:fetch).with(key).and_call_original
        allow(ENV).to receive(:fetch).with(key, anything).and_call_original
      end

      def env_stubbed?
        ENV[STUBBED_KEY]
      end

      def init_stub
        clean_stub
        add_stubbed_value(STUBBED_KEY, true)
      end

      def clean_stub
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:fetch).and_call_original
      end
    end
  end
end
