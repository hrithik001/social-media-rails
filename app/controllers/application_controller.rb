class ApplicationController < ActionController::Base
    before_action :set_current_user
    # before_action :user_logged_in?
    def set_current_user
        if session[:user_session_id]
            # Current.user = User.find_by(id:  )
            if ActiveSession.where(session_id: session[:user_session_id],status: "active").exists?
                Current.user ||= User.find(ActiveSession.find_by(session_id: session[:user_session_id],status: "active").user_id)
                flash[:notice] = "#{Current.user.inspect}"
            else
                session[:user_session_id] = nil
                Current.user = nil
            end
        end
    end
    def user_logged_in?
        redirect_to sign_in_path, alert: 'Please sign in first' if Current.user.nil?
    end

end
