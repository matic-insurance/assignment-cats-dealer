module ApiConcern
  extend ActiveSupport::Concern

  def parameters
    request.parameters
  end
end
