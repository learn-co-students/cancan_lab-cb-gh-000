class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_or_create_by(name: params[:user][:name])
    session[:user_id] = user.id
    redirect_to '/'
  end

  def destroy
    session.delete :user_id
    redirect_to login_path
  end
end
