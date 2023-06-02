class ProductRepository
  include Repository
  include Pagy::Backend

  attr_reader :pages, :errors

  def initialize(model:, record:)
    @model = model
    @record = record
    @filtered = nil
  end

  def index(filter)
    page = filter[:page] || 1
    name = filter[:name]
    active
    filter_by_name(name) if name.present?
    @pages, products = pagy(filtered.order(:created_at), page: page)

    products.map { |product_record| @model.new(product_record.attributes) }
  rescue Pagy::OverflowError => e
    @errors = e
    []
  end

  def inactive(id)
    record = filtered.find_by_id(id)
    return record.update(state: false) if record.present? && record.state

    false
  end

  def fetch_by_id(id)
    record = filtered.find_by_id(id)
    return Types::Undefined if record.blank?

    @model.new(record.attributes)
  end

  def filter_by_name(term)
    @filtered = filtered.where('lower(name) LIKE ?', "%#{term.downcase}%")
  end

  def active
    @filtered = filtered.where(state: true)
  end

  private

  def filtered
    @filtered ||= @record
  end
end
