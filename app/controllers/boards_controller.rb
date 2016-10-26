class BoardsController < ApplicationController
  before_action :check_login
  before_action :set_board, only: [:edit, :update, :destroy, :show]
  
  def index
    
    if params[:category].present?
      
      @boards = Board.where(category: params[:category]).page(params[:page])
#       @boards = Board.tagged_with(params[:category]).order(created_at: :desc).page(params[:page]).per(3)
    else
      
      @boards = Board.page(params[:page])
    end
      
    
  end
  
  def new
    @board = Board.new
  end
  
  def create
    require 'open-uri'
    require 'nokogiri'
    
    @ccc = Board.create(boards_params)
    @idid = @ccc.id
    @board = Board.find(@idid)
    @urlurl = Board.find(@idid).board_url
    
    uri = @urlurl

    page = URI.parse(uri).read
    charset = page.charset
    if charset == "iso-8859-1"
      charset = page.scan(/charset="?([^\s"]*)/i).first.join
    end

    doc = Nokogiri::HTML.parse(page, uri, charset)

    @board.board_title = doc.title.to_s.encode("UTF-8")
    
    if doc.css('//meta[property="og:description"]/@content').empty?
      @board.board_discription = doc.css('//meta[name$="escription"]/@content').to_s.truncate(100)
    else
      @board.board_discription = doc.css('//meta[property="og:description"]/@content').to_s.truncate(100)
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
    
    @comment = @post.comments.build
    @comments = @post.comments
    
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
    
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
      params.require(:board).permit(:board_url,:board_title,:board_content,:board_image,:board_discription,:category)
    end
    
    def set_board
      @board = Board.find(params[:id])
    end

    def check_login
      redirect_to entrance_index_path unless user_signed_in?
    end
end