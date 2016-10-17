class PostsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy, :show]
  
  def index
    @posts = Post.all
  end
  
  def new
 #   @postboardid = params[:board_id]

    if params[:back]
      @post = Post.new(posts_params)
    else
      @post = Post.new
      @post.board_id = params[:board_id]
      @post.save
    end
  end
  
  def show
    @comment = @post.comments.build
    @comments = @post.comments
  end
  
  def create
    

    @post = Post.new(posts_params)
    @post.user_id = current_user.id
    @post.user_name = current_user.name
    @post.provider = current_user.provider
    @post.image_url = current_user.image_url
    @post.avatar = current_user.avatar
    

    if @post.save
      redirect_to board_path(@post.board_id), notice: "作成しました！"
    else
      render action: 'new'
    end
  end
  
  
  def edit
  end
  
  def update
    @post.update(posts_params)
    redirect_to board_path(@post.board_id)
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
      params.require(:post).permit(:title,:message,:board_id)
    end
    
    def set_post
      @post = Post.find(params[:id])
    end

end
