class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_users, only: [:show]
  
  def index
    @users = User.all
    
    @search = User.search(params[:q])
    @topics = @search.result(distinct: true)
    @topicsize = @topics.size

    respond_to do |format|
      format.html
      format.json {render json: @topics }
    end
      
  end
  
  def show
    @followed = current_user.followed_users
    @follower = current_user.followers
    
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
      params.require(:users).permit(:name,:email)
    end
    
    def set_users
      @user = User.find(params[:id])
    end
end
