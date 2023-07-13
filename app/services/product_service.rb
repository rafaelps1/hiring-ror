class ProductService
  include Dry::Monads[:do, :result, :try]

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
    product = yield build_product
    result = yield save(product)
    Success(result)
  end

  def inactive
    product = yield fetch_by(id: @id)
    result = yield inactive!(product)

    Success(result)
  end

  def list
    products = Try { repository.index(@filter) }
    return Failure([{ code: 121, message: products.exception.message }]) if products.error?

    products.to_result
  end

  private

  def build_product
    @product_hash[:price] = Try { Types::Params::Float[@product_hash[:price]] }.value_or(0)
    @product_hash[:state] = Try { Types::Params::Bool[@product_hash[:state]] }.value_or(true)
    errors = valid_fields!
    return Failure(errors) if errors.any?

    Success(Entity::Product.new(@product_hash))
  end

  def fetch_by(fields = {})
    Try { repository.fetch_by(fields) }.to_result
  end

  def inactive!(product)
    return Failure({ id: 10, message: I18n.t('errors.product.already_inactive'), status: 422 }) unless product.state

    Try { repository&.update({ state: false }) }.to_result
  end

  # Persists product on database through repository
  #
  # @param [Entity::Product] product
  # @return Dry::Monads::Result
  #
  # @api private
  def save(product)
    repository.product = product
    Try { repository.save(user_id: @user_id) }.to_result
  end

  def valid_fields!
    performed_contract = Entity::Contract::ProductContract.new.call(@product_hash)
    performed_contract.errors.to_a.map { |err| { code: 121, source: err.path, message: err.text } }
  end
end
