class BoardsController < ApplicationController
  
  before_action :set_board, only: [:edit, :update, :destroy, :show]
  
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
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  def confirm
  end
  
  def show
    @posts = @board.posts
  end
  
  
  private
    def boards_params
      params.require(:board).permit(:board_url,:board_title,:board_content)
    end
    
    def set_board
      @board = Board.find(params[:id])
    end

end