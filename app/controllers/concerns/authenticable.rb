module Authenticable
  def current_user
    return @current_user if @current_user

    auth_token = request.headers['Authorization']
    return nil if auth_token.nil?

    decoded = JsonWebToken.decode(auth_token)
    @current_user = Entity::User.fetch_by(id: decoded[:user_id])
  end

  protected

  def check_login
    current_user.present?
  end
end
