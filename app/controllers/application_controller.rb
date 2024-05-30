class ApplicationController < ActionController::Base
    before_action :set_current_user
    before_action :check_session_timeout
    
    def set_current_user
        if session[:user_session_id]
            # Current.user = User.find_by(id:  )
            if ActiveSession.where(session_id: session[:user_session_id],session_status: true).exists?
                Current.user ||= User.find(ActiveSession.find_by(session_id: session[:user_session_id],session_status: true).user_id)
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
    
    def check_session_timeout
        if session[:user_session_id]
          latest_session = ActiveSession.find_by(session_id: session[:user_session_id])
          puts latest_session.session_expiry, Time.current, "++++++++++++++++++++++++"
          if latest_session && Time.current > latest_session.session_expiry
            session[:user_session_id] = nil
            reset_session
            redirect_to sign_in_path, alert: "Your session has timed out. Please sign in again."
          end
        end
      end

end
