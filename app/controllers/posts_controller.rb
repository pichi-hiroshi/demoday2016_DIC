class PostsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end
  
  def new
    if params[:back]
      @post = Post.new(posts_params)
    else
      @post = Post.new
    end
  end
  
  def create
#    Post.create(posts_params)
#    redirect_to posts_path, notice: "作成しました！" 
    
    @post = Post.new(posts_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "作成しました！"
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    @post.update(posts_params)
    redirect_to posts_path
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path
  end
  
  def confirm
    @post = Post.new(posts_params)
    render :new if @post.invalid?
  end
  
  private
    def posts_params
      params.require(:post).permit(:post_title,:post_message,:datasource,:datasource_url)
    end
    
    def set_post
      @post = Post.find(params[:id])
    end

end
