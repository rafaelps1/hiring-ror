class LoginTokenService
  prepend Command
  include Dry::Monads[:result, :try]
  include Dry::Monads::Do.for(:call)

  def initialize(email:, password:, repository: UserRepository)
    @email = email
    @password = password
    @repository = repository.new
  end

  def call
    @user = yield fetch_user_by_email
    authenticate
  end

  private

  def authenticate
    auth = Try { @repository.record&.authenticate(@password) }.to_result
    return Failure(:fail_authorized) if auth.failure?
    return Failure(:unauthorized) unless auth.success

    make_token
  end

  def fetch_user_by_email
    user = Try { @repository.fetch_by(email: @email) }.to_result
    return Failure(:not_found) if user.failure?

    Success(user)
  end

  def make_token
    token = Try { Authenticable::JsonWebToken.encode(user_id: @user.success.id) }.to_result
    return Failure(:fail_make_token) if token.failure?

    Success({ email: @email, token: token.success })
  end
end
