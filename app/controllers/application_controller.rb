class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_required
  	redirect_to '/' if !session[:user_id]
  end

  def current_user
  	@current_user ||= User.find_by_id(session[:user_id])
  end
end
