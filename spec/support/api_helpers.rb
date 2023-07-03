module ApiHelpers
  def json(response)
    return {} if response.body.blank?

    JSON.parse(response.body)
  end
end
