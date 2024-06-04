class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_comment, only: [:edit, :update, :destroy]
    before_action :authorize_comment!, only: [:edit, :update, :destroy]
  
    def create
      @comment = @post.comments.build(comment_params)
      @comment.user = Current.user
  
      if @comment.save
        redirect_to @post, notice: 'Comment was successfully created.'
      else
        flash[:alert] = @comment.errors.full_messages.to_sentence
        flash[:model_errors] =  @comment.errors.full_messages_for(:base).to_sentence 
        redirect_to @post
      end
    end
  
    def edit
    end
  
    def update
      if @comment.update(comment_params)
        redirect_to @post, notice: 'Comment was successfully updated.'
      else
        flash[:model_errors] =  @comment.errors.full_messages_for(:base).to_sentence 
        render :edit
      end
    end
  
    def destroy
      @comment.destroy
      redirect_to @post, notice: 'Comment was successfully deleted.'
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def set_comment
      @comment = @post.comments.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:content, :post_id, :parent_id)
    end
  
    def authorize_comment!
      unless can_manage_comment?
        flash[:model_errors] =  @comment.errors.full_messages_for(:base).to_sentence 
        redirect_to @post, alert: 'You do not have permission to perform this action.'
      end
    end
  
    def can_manage_comment?
      Current.user.admin? || @comment.user == Current.user || (@comment.user != Current.user && @post.user == Current.user && action_name == 'destroy')
    end
  end
  