require 'utilities/env_reader'

describe ENVReader do
  subject(:reader) { described_class }

  describe '#fetch_variable' do
    let(:variable_name) { 'REQUIRED_VARIABLE' }

    it 'returns variable if it exists' do
      expected_value = '8080'

      stub_env(variable_name, expected_value)

      result = reader.fetch_variable(variable_name)
      expect(result).to eq expected_value
    end

    context 'ENV variable does not exist' do
      it 'fails with message if no block is passed' do
        message = "Add #{variable_name} to .env"

        expect { reader.fetch_variable(variable_name) }.to raise_error(ArgumentError, message)
      end

      it 'yield to block if one is passed' do
        expected_return = 'Failed to fetch variable'
        block = proc { expected_return }

        result = reader.fetch_variable(variable_name, &block)
        expect(result).to eq expected_return
      end
    end
  end
end
