class PostsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy, :show]
  
  def index
    @posts = Post.all
  end
  
  def new
 #   @postboardid = params[:board_id]

    if params[:back]
      @post = Post.new(post_params)
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
    @post = current_user.posts.build(post_params)
    @board = @post.board
#    @notification = @post.notifications.build(user_id: @board.user.id )
    
    respond_to do |format|
      if @post.save
#        unless @post.board.user_id == current_user.id
          format.html { redirect_to board_path(@board) }
          format.json {render :show, status: :created, location: @post }
          
=begin
          Pusher.trigger("user_#{@post.board.user_id}_channel", 'post_created', {
            message: 'あなたの作成した記事にslideが付きました'
            })
          end
          
          Pusher.trigger("user_#{@post.board.user_id}_channel", 'notification_created', {
            uncreate_count: Notification.where(user_id: @post.board.user.id).count
          })
=end
            
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  
    # 通知機能に使うもの
    

      
  
  
=begin
    @post = Post.new(post_params)
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
=end

  end #create
  
  
  def edit
  end
  
  def update
    @post.update(post_params)
    redirect_to board_path(@post.board_id)
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path
  end
  
  def confirm
    @post = Post.new(post_params)
    render :new if @post.invalid?
  end
  
  private
    def post_params
      params.require(:post).permit(:title,:message,:board_id,:avatar)
    end
    
    def set_post
      @post = Post.find(params[:id])
    end

end
