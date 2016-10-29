class BoardsController < ApplicationController
  before_action :check_login
  before_action :set_board, only: [:edit, :update, :destroy, :show, :search]
  
  def index
    
    if params[:category].present?
      
      @boards = Board.where(category: params[:category]).page(params[:page])
#       @boards = Board.tagged_with(params[:category]).order(created_at: :desc).page(params[:page]).per(3)
    else
      
      @boards = Board.page(params[:page])
    end
    
    
      @search = Board.search(params[:q])
      @topics = @search.result(distinct: true)
      @topicsize = @topics.size

      respond_to do |format|
        format.html
        format.json {render json: @topics }
      end
  end
  
  def search
    @search = Board.search(params[:q])
    @topics = @search.result(distinct: true)
    
    respond_to do |format|
      format.html
      format.json {render json: @topics }
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

#そのURLの記事がすでに存在するか調べる
    @ididid = @idid - 1
    if Board.where(id: 1..@ididid).exists?(board_url: @board.board_url)
       @exist = Board.find_by(board_url: @board.board_url)
       Board.find(@idid).destroy
       redirect_to board_path(@exist.id), notice: 'その記事はすでに存在しています！'
    else

#記事が存在しない場合、nokogiriを使ってスクレイピングする
      @board.user_id = current_user.id
      
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

      redirect_to board_path(@board.id), notice: '記事を作成しました！'
    end
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
    
    @user = User.find(@board.user_id)
    
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]

    @search = Board.search(params[:q])
    @topics = @search.result(distinct: true)
    
    respond_to do |format|
      format.html
      format.json {render json: @topics }
    end
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