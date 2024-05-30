class RegistrationsController < ApplicationController
    def new
        @user = User.all
    end
    def create
        @user = User.new(user_params)
        if @user.save
          session_id = SecureRandom.uuid
          @user_active_session = ActiveSession.new(user_id: @user.id, session_id: session_id, session_expiry: 30.minutes.from_now, session_status: true)
          @user_active_session.save
          session[:user_session_id] = session_id
          redirect_to root_path, notice: "#{@user.role} is created successfully!!"
        else
          render :new, status: :unprocessable_entity
        end
      end
      
        
     
      
        private
          
          def user_params
            params.require(:user).permit(:email, :password, :password_confirmation, :role)
          end
      

end
