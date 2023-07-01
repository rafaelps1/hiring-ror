if @errors&.any?
  json.errors @errors do |error|
    json.message error
  end
end

if @product.present?
  json.set! :data do
    json.id @product.id
    json.name @product.name
    json.title @product.title
    json.price @product.price
    json.photo @product.photo
    json.state @product.state
  end
end
