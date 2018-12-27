class SessionsController < ApplicationController

	def new

	end

	def create
		@user = User.find_by_name(params[:name])
		if @user
			session[:user_id] = @user.id
			redirect_to '/', alert: "Logged In!"
		else
			redirect_to login_path
		end
	end
end
