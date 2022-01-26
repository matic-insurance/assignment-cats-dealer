# frozen_string_literal: true

module AcceptanceMacros
  def json
    if json_response? && response_body.present?
      JSON.parse(response_body)
    else
      response_body
    end
  end

  def json_response?
    response_headers['Content-Type']&.match?(%r{\Aapplication/json.*})
  end
end
