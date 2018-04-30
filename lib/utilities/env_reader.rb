module ENVReader
  def fetch_variable(name)
    ENV.fetch(name) do
      raise(ArgumentError, "Add #{name} to .env") unless block_given?
      yield
    end
  end

  module_function :fetch_variable
end
