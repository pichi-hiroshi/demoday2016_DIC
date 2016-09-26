class InfosController < ApplicationController
  def index
    @infos = Info.all
  end
  
  def new
    @info = Info.new
  end
  
  def create
    Info.create(infos_params)
    redirect_to infos_path
  end
  
  private
    def infos_params
      params.require(:info).permit(:info_date,:info_title,:info_content)
    end

end