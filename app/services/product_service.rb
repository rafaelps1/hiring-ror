class ProductService
  include Dry::Monads[:result, :do]

  attr_reader :repository

  def initialize(repository: ProductRepository)
    @repository = repository.new
  end

  def call(id: nil, filter: {}, product_hash: {}, user_id: nil)
    @id = id
    @filter = filter
    @user_id = user_id
    @product_hash = product_hash

    self
  end

  def create_product
    cast_fields
    performed_contract = Entity::Contract::ProductContract.new.call(@product_hash)
    contract_errors = performed_contract.errors.to_a.map { |err| { code: 121, source: err.path, message: err.text } }
    return Failure(contract_errors) if contract_errors.any?

    product = Entity::Product.new(@product_hash)
    save(product)
    Success(product)
  end

  def fetch_by_id
    return Failure(:bad_request) if @id.blank?

    product = repository.fetch_by(id: @id)
    errors = repository.errors
    return Failure(errors) if errors.any?

    Success(product)
  end

  def inactive
    result = fetch_by_id
    return Failure(result.failure) if result.failure?

    return Success(repository&.update({ state: false })) if result.success.state

    Failure([:unprocessable_entity, result.success])
  end

  def list
    pages, products = repository.index(@filter)
    errors = repository.errors
    return Failure(errors) if errors.any?

    Success([products, pages])
  end

  private

  def cast_fields
    @product_hash[:price] = Types::Params::Float[@product_hash[:price]]
    @product_hash[:state] = @product_hash[:state] ? Types::Params::Bool[@product_hash[:state]] : true
  end

  def save(product)
    repository.product = product
    try { repository.save(user_id: @user_id) }
  end
end
