class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end
  
  def new
    @board = Board.new
  end
  
  def create
    Board.create(boards_params)
    redirect_to boards_path
  end
  
  private
    def boards_params
      params.require(:board).permit(:board_url,:board_title,:board_content)
    end

end