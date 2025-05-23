module Authenticateable
  def current_user
    token = request.headers["Authorization"]
    @current_user ||= User.find_by(token: token)
  end

  def authenticate_with_token
    unless current_user
      render json: { errors: "Not authenticated" }, status: :unauthorized
    end
  end

  def user_signed_in?
    current_user.present?

  end
end
