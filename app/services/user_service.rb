class UserService
  include Dry::Monads[:do, :result, :try]

  attr_reader :repository

  def initialize(repository: UserRepository)
    @repository = repository.new
  end

  def call(id: nil, user_hash: {})
    @id = id
    @user_hash = user_hash
    self
  end

  def create_user
    user_new = yield build_user
    result = yield save(user_new)
    Success(result)
  end

  def destroy
    user = yield fetch_by(id: @id)
    result = yield destroy_record

    Success(result)
  end

  def show_user
    fetch_by(id: @id)
  end

  private

  def build_user
    errors = valid_fields!
    return Failure(errors) if errors.any?

    Success(Entity::User.new(@user_hash))
  end

  def destroy_record
    Try { repository.destroy }.to_result
  end

  def fetch_by(fields = {})
    user = Try { repository&.fetch_by(fields) }.to_result
    return Failure({ id: 100, status: 204, title: 'Not found' }) unless user.success

    user
  end

  def save(user)
    repository.user = user
    Try { repository.save }.to_result
  end

  def valid_fields!
    performed_contract = Entity::Contract::UserContract.new.call(@user_hash)
    performed_contract.errors.to_a.map { |err| { id: 130, source: err.path, title: err.text } }
  end
end
