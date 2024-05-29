class ApplicationController < ActionController::Base
    before_action :set_current_user
    # before_action :user_logged_in?
    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
            flash[:notice] = "#{Current.user.inspect}"
        end
    end
    def user_logged_in?
        redirect_to sign_in_path, alert: 'Please sign in first' if Current.user.nil?
    end

end
