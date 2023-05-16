module Authenticable
  def current_user
    return @current_user if @current_user

    auth_token = request.headers['Authorization']
    return nil if auth_token.nil?

    decoded = JsonWebToken.decode(auth_token)
    @current_user = User.find_by_id(decoded[:user_id])
  end

  protected

  def check_login
    head :forbidden unless current_user
  end
end
