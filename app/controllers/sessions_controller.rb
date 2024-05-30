class SessionsController < ApplicationController
    def new
        
    end
    def create
        user = User.find_by(email: params[:email])
        if user.present? && user.authenticate(params[:password]) && user[:role] == params[:role]
            session_id = SecureRandom.uuid
            @user_active_session = ActiveSession.new(user_id: user.id, session_id: session_id, session_expiry: 15.minutes.from_now, session_status: true)
            @user_active_session.save
            session[:user_session_id] = session_id
            redirect_to root_path,notice: "logged in successfully as #{user[:role]}"
        else
            flash[:alert] = "Not valid "
            render :new ,status: :unprocessable_entity
        end
        
    end
    def destroy
        if session[:user_session_id]
                ActiveSession.find_by(session_id: session[:user_session_id]).update(session_status: false)
                session[:user_session_id] = nil
                redirect_to root_path ,notice: 'logged out successfully'
        end
    end
    private

    def user_params
        params.require(:user).permit(:email,:password,:role)
    end
end