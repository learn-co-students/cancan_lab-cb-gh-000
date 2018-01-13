class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.name = params[:user][:name]
    if @user.save
      redirect_to notes_path
    else
      redirect_to '/sign_up'
    end
  end

end
