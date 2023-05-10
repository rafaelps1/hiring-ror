module Authenticable
  def current_user
    return @current_user if @current_user

    auth_token = request.headers['Authorization']
    return nil if auth_token.nil?

    decoded = JsonWebToken.decode(auth_token)
    @current_user = begin
      User.find_by_id(decoded[:user_id])
    rescue StandardError
      ActiveRecord::RecordNotFound
    end
  end

  protected

  def check_login
    head :forbidden unless current_user
  end
end
