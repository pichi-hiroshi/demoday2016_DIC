class DashboardsController < ApplicationController
  before_action :check_login
  
  def index
  end
  
  private
    def check_login
      redirect_to entrance_index_path unless user_signed_in?
    end
end
