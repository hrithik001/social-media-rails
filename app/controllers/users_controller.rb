class UsersController < ApplicationController
    before_action :authorize_admin
  
    def index
      @users = User.all
    end
  
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_url, notice: 'User was successfully deleted.'
    end
  
    private
  
    def authorize_admin
      redirect_to root_path, alert: 'You are not authorized to perform this action.' unless Current.user.admin?
    end
  end