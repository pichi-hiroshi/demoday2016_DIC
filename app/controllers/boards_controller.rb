class BoardsController < ApplicationController
  before_action :check_login
  before_action :set_board, only: [:edit, :update, :destroy, :show]
  
  def index
    @boards = Board.all
  end
  
  def new
    @board = Board.new
  end
  
  def create
    require 'open-uri'
    
    @ccc = Board.create(boards_params)
    @idid = @ccc.id
    @board = Board.find(@idid)
    @urlurl = Board.find(@idid).board_url
    
    url = @urlurl
    
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    
    doc = Nokogiri::HTML.parse(html, nil, charset)

    @board.board_title = doc.title.to_s
    
    if doc.css('//meta[property="og:description"]/@content').empty?
      @board.board_discription = doc.css('//meta[name$="escription"]/@content').to_s
    else
      @board.board_discription = doc.css('//meta[property="og:description"]/@content').to_s
    end
    
    @board.board_image = doc.css('//meta[property="og:image"]/@content').to_s
    
    @board.save
    
    redirect_to board_path(@board.id)
#    render :template => "user/show"
    
  end
  
  def edit
  end
  
  def update
    if @board.update(boards_params)
      redirect_to board_path(@board.id)
    else
      render action: 'edit'
    end
  end
  
  def destroy
  end
  
  def confirm
    @board = Board.new(boards_params)
  end
  
  def show
    @post = @board.posts.build
    @posts = @board.posts

    
=begin
    @posts = @board.posts
#    @comments = @posts.comments

#下の2つ　後で消す
    @allboard = Board.all.includes(posts: :comments)
    @thisboard = @allboard.find(params[:id])
=end
  end
  
  private
    def boards_params
      params.require(:board).permit(:board_url,:board_title,:board_content,:board_image,:board_discription)
    end
    
    def set_board
      @board = Board.find(params[:id])
    end

    def check_login
      redirect_to entrance_index_path unless user_signed_in?
    end
end