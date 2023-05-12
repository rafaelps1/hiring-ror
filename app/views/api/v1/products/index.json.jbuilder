json.data @products do |product|
  json.id product.id
  json.name product.name
  json.title product.title
  json.price product.price
  json.photo product.photo
  json.state product.state
end

if @pagy.present?
  json.set! :links do
    json.href '/products?page=1'
    json.rel 'pagination'
    json.page (@pagy.page || '').to_s
    json.first @pagy.count&.negative? ? '0' : '1'
    json.last (@pagy.last || '').to_s
    json.prev (@pagy.prev || '').to_s
    json.next (@pagy.next || '').to_s
  end
end
