module ApiHelpers
  def sanitize(data)
    data.errors.to_h.flatten
  end

  def json(response)
    JSON.parse(response.body)
  end
end
