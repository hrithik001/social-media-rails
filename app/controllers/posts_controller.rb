class PostsController < ApplicationController
  before_action :user_logged_in?
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
 

  def index

    @page = params.fetch(:page,0).to_i
    @posts = Post.all.offset(@page * POST_PER_PAGE).limit(POST_PER_PAGE)
    @myPosts = if Current.user.role == 'admin' || Current.user.role == 'author'
                    Post.where(user: Current.user)
               end
    @comment_field = false
   
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Current.user.posts.build(post_params)
    Rails.logger.info "----------------------inside create-----------------------------------"
    if @post.save
      # redirect_to @post, notice: 'Post was successfully created.'
      redirect_to root_path,notice: 'Post was successfully created'
      Rails.logger.info "----------------------posts saved-----------------------------------"
    else
      Rails.logger.info "----------------------posts not saved-----------------------------------"
      render :new ,status: :unprocessable_entity, alert: 'Post was not created' 
    end
    Rails.logger.info "----------------------leaving create-----------------------------------"
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:content)
  end

  def authorize_user
    unless Current.user.admin? || @post.user == Current.user
      redirect_to posts_path, alert: 'You are not authorized to perform this action.'
    end
  end

end
