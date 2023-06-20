class UserService
  prepend Command

  attr_reader :repository

  delegate :destroy, :save, to: :repository

  def initialize(id: nil, user_hash: {}, repository_type: :db)
    @id = id
    @user_hash = user_hash
    @repository = UserRepository.new if repository_type == :db
  end

  def call
    return                        if @id.blank? && @user_hash.blank?
    return build_user(@user_hash) if @user_hash.present?

    fetch_by_id if @id.present?
  end

  def errors
    @errors ||= @contract_errors + @repository&.errors
  end

  def fetch_by_id
    return if @id.blank?

    repository&.fetch_by(id: @id)
  end

  def valid?
    errors.empty?
  end

  protected

  def build_user(params)
    performed_contract = Entity::Contract::UserContract.new.call(params)
    @contract_errors = performed_contract.errors.to_a.map { |err| "#{err.path} #{err.text}" }
    return if @contract_errors.any?

    user = Entity::User.new(params)
    repository.user = user
    user
  end
end
