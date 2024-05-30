class MypostsController < ApplicationController
    def index
        @posts = Post.where(user_id: params[:id])
        @author_username= User.find_by(id: params[:id]).email
        
    end
end