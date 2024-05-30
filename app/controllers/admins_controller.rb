class AdminsController < ApplicationController

    def index
        @authors = User.where(role: 'author')
    end
    def destroy
        
    end
end
