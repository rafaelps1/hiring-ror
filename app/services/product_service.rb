class ProductService
  prepend Command

  attr_accessor :id
  attr_reader :repository

  delegate :destroy, :pages, :save, to: :repository

  def initialize(id: nil, filter: {}, product_hash: {}, repository_type: :db)
    @id = id
    @filter = filter
    @product_hash = product_hash
    @errors = []
    @repository = ProductRepository.new if repository_type == :db
  end

  def call
    return              if @id.blank? && @product_hash.blank? && @filter.blank?
    return list         if @filter.present?
    return fetch_by_id  if @id.present?
    return              unless @product_hash.present?

    build_product(@product_hash)
  end

  def errors
    return @errors if @errors.present?

    @errors.push(@coercion_errors) if @coercion_errors.present?
    @contract_errors.each { |err| @errors.push(err) } if @contract_errors.present?
    repository_errors = @repository&.errors
    @errors.push(repository_errors) if repository_errors.present?
    @errors
  end

  def fetch_by_id
    return if @id.blank?

    repository&.fetch_by(id: @id)
  end

  def inactive
    return repository&.update({ state: false }) if repository&.record&.state
  end

  def list
    repository.index(@filter) || []
  end

  def product_create(user_id)
    return repository.save(user_id: user_id) if valid?
  end

  def valid?
    errors.empty?
  end

  def build_product(params)
    casted_params = cast_params(params)
    return if casted_params.blank?

    performed_contract = Entity::Contract::ProductContract.new.call(casted_params)
    @contract_errors = performed_contract.errors.to_a.map { |err| { code: 121, source: err.path, message: err.text } }
    return unless valid?

    product = Entity::Product.new(casted_params)
    repository.product = product
    product
  end

  private

  def cast_params(params)
    params[:price] = Types::Params::Float[params[:price]]
    params[:state] = params[:state] ? Types::Params::Bool[params[:state]] : true
    params
  rescue Dry::Types::CoercionError => e
    @coercion_errors = { code: 120, message: e.message.strip.capitalize }
    nil
  end
end
