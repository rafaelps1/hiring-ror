module Authenticable
  def current_user
    return @current_user if @current_user

    auth_token = request.headers['Authorization']
    return nil if auth_token.nil?

    decoded = JsonWebToken.decode(auth_token)
    @current_user = UserRepository.new.fetch_by(id: decoded[:user_id])
  end

  protected

  def check_login
    current_user.present?
  end

  class JsonWebToken
    SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

    def self.encode(payload, exp = 36.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def self.decode(token)
      decoded = JWT.decode(token, SECRET_KEY).first
      HashWithIndifferentAccess.new(decoded)
    rescue JWT::VerificationError, JWT::DecodeError => e
      HashWithIndifferentAccess.new(code: 401, message: e.message, user_id: 0)
    end
  end
end
