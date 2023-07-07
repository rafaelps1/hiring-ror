class ProductRepository
  include Repository
  include Pagy::Backend

  attr_accessor :product
  attr_reader :record, :errors

  def initialize(product = nil)
    @product = product
    @errors = []
  end

  def active
    @filtered = filtered.where(state: true)
  end

  def fetch_by(options = {})
    return if options.blank?

    @record = filtered.find_by(options)
    return if record.blank?

    build_product(record.attributes)
  end

  def update(product_hash)
    return record.update(product_hash) if record.present? && product_hash.is_a?(Hash)

    false
  end

  def index(filter)
    page = filter[:page] || 1
    name = filter[:name]
    active
    filter_by_name(name) if name.present?
    pages, products = pagy(filtered.order(:created_at), page: page)

    [pages, products.map { |prod_record| build_product(prod_record.attributes) }]
  rescue Pagy::OverflowError => e
    @errors << { code: 121, message: e.message }
    []
  end

  def filter_by_name(term)
    @filtered = filtered.where('lower(name) LIKE ?', "%#{term.downcase}%")
  end

  def save(options = {})
    return if product.blank?

    attributes = product&.attributes&.merge(options)
    @record = product_record.new(attributes)
    return build_product(@record.attributes) if record.save
  end

  private

  def build_product(fields)
    Entity::Product.new(fields)
  end

  def filtered
    @record = product_record if record.blank?
    @filtered ||= record
  end

  def product_record
    ProductRecord
  end
end
