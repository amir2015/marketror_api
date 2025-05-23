module Authenticateable
  def current_user
    token = request.headers["Authorization"]
    @current_user ||= User.find_by(token: token)
  end
end
