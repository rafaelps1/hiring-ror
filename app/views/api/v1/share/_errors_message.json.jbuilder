if @errors
  json.errors @errors do |error|
    detail = error[:detail]
    status = error[:status]

    json.id error[:id]
    json.title error[:title]
    json.detail detail if detail
    json.status status if status
  end
end
