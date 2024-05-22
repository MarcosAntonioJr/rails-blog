class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, except: [:index, :new, :create]

  def index
    @posts = Post.includes(:comments).order(created_at: :desc)
    @pagy, @posts = pagy(@posts)
  end

  def show
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post was successfully created"
    else
      render :new , status: :unprocessable_entity

    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit , status: :unprocessable_entity
    end
  end

  def destroy
      @post.destroy
      redirect_to root_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.includes(:comments).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

end