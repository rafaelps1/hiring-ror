module Authenticable
  def current_user
    return @current_user if @current_user

    auth_token = request.headers['Authorization']
    return nil if auth_token.nil?

    decoded = JsonWebToken.decode(auth_token)
    @current_user = User.find(decoded[:user_id]) rescue ActiveRecord::RecordNotFound
  end
end
