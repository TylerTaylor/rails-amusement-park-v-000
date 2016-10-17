module UsersHelper
  def current_user
    User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end
end
