module ApiHelpers
  def sanitize(data)
    return {} if data.blank?

    data.errors.to_h.flatten
  end

  def json(response)
    return {} if response.body.blank?

    JSON.parse(response.body)
  end
end
