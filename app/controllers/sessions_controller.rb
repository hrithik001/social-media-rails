class SessionsController < ApplicationController
    def new
        
    end
    def create
        user = User.find_by(email: params[:email])
        if user.present? && user.authenticate(params[:password]) && user[:role] == params[:role]
            session[:user_id] = user.id
             redirect_to root_path,notice: "logged in successfully as #{user[:role]}"
        else
            flash[:alert] = "Not valid "
            render :new ,status: :unprocessable_entity
        end
        
    end
    def destroy
        session[:user_id] = nil
        redirect_to root_path ,notice: 'logged out successfully'
    end
    private

    def user_params
        params.require(:user).permit(:email,:password,:role)
    end
end