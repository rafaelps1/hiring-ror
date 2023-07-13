if @errors&.any?
  json.errors @errors do |error|
    json.code error[:code]
    json.detail error[:message]
    json.title error[:title]
  end
end

if @products&.any?
  json.data @products do |product|
    json.id product.id
    json.name product.name
    json.title product.title
    json.price product.price
    json.photo product.photo
    json.state product.state
  end

  if @pages.present?
    current_page = (@pages.prev || 0) + 1
    json.set! :links do
      json.rel "current page: #{current_page}"
      json.first api_v1_products_url(page: 1)
      json.last api_v1_products_url(page: @pages.last)
      json.prev api_v1_products_url(page: @pages.prev)
      json.next api_v1_products_url(page: @pages.next)
    end
  end
end
