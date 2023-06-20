class TokenService
  prepend Command

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    user_repositoty = UserRepository.new.fetch_by(email: @email)
    user = user_repositoty.record
    return {} unless user&.authenticate(@password)

    { email: user.email, token: Authenticable::JsonWebToken.encode(user_id: user.id) }
  end

  def logged?
    result.present? && result[:token]
  end
end
