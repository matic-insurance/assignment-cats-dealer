module ResponseStructure
  Response = Struct.new(
    :success?,
    :data,
    :errors,
    :status,
    keyword_init: true
  )

  def respond_with_success(data = nil, status = :ok)
    Response.new(
      success?: true,
      status: status,
      data: data
    )
  end

  def respond_with_error(errors = nil, status = :bad_request)
    Response.new(
      success?: false,
      status: status,
      errors: errors
    )
  end
end
