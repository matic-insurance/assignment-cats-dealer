module Cats
  class ListService
    include BaseService

    def initialize(params)
      @params = params
      @contract = initialize_contract
    end

    def perform
      return respond_with_error(contract.errors.to_h) if contract.failure?

      prepare_cats_list

      respond_with_success(cats_list)
    end

    private

    attr_reader :contract,
                :params,
                :cats_list

    def initialize_contract
      @contract = Cats::ListContract.new.(params)
    end

    def prepare_cats_list
      @cats_list = Cats::ManagerService.(contract.to_h)
    end
  end
end
