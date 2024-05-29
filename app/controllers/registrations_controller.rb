class RegistrationsController < ApplicationController
    def new
        @user = User.all
    end
    def create
        @user = User.new(user_params)
        if @user.save
          session[:user_id] = @user.id
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
