module Requests
  class CreateService
    include BaseService

    def initialize(params)
      @errors = params.fetch(:errors) { {} }
    end

    def perform
      prepare_form_data

      respond_with_success(result)
    end

    private

    attr_reader :errors,
                :result

    def prepare_form_data
      @result = {
        errors: errors,
        locations: Cats::ListContract::LOCATIONS,
        cat_types: Cats::ListContract::CAT_TYPES
      }
    end
  end
end
