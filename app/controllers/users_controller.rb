class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_users, only: [:show]
  
  
  def index
    @users = User.all
  end
  
  def show
  end
  
  private
    def posts_params
      params.require(:users).permit(:name,:email)
    end
    
    def set_users
      @user = User.find(params[:id])
    end
end
