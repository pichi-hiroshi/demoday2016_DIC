class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_users, only: [:show]
  
  def index
#    @users = User.all
    @users = User.page(params[:page])
    
    @search = User.search(params[:q])
    @topics = @search.result(distinct: true)
    @topicsize = @topics.size

    respond_to do |format|
      format.html
      format.json {render json: @topics }
    end
      
  end
  
  def show
    @followed = @user.followed_users
    @follower = @user.followers
    
    @boards = Board.where(user_id: @user.id)
    @posts = Post.where(user_id: @user.id)
    
    
    @search = User.search(params[:q])
    @topics = @search.result(distinct: true)
    @topicsize = @topics.size

    respond_to do |format|
      format.html
      format.json {render json: @topics }
    end
    
  end
  
  private
    def posts_params
      params.require(:users).permit(:name,:email,:affiliation,:discription)
    end
    
    def set_users
      @user = User.find(params[:id])
    end
end
