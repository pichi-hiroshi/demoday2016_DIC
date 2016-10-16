class BoardsController < ApplicationController
  
  before_action :set_board, only: [:edit, :update, :destroy, :show]
  
  def index
    @boards = Board.all
    
    require 'open-uri'
    
    url = 'http://www.sankei.com/economy/news/161015/ecn1610150024-n1.html'
    
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    
    doc = Nokogiri::HTML.parse(html, nil, charset)
    
    @node = doc.xpath('//li[@class="mdTopMTMList01Item"]').css('h3').inner_text

    @pagetitle = doc.title.to_s
    
    if doc.css('//meta[property="og:description"]/@content').empty?
      @pagediscription = doc.css('//meta[name$="escription"]/@content').to_s
    else
      @pagediscription = doc.css('//meta[property="og:description"]/@content').to_s
    end
    
    @pageimage = doc.css('//meta[property="og:image"]/@content').to_s
    
    
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
    @board = Board.new(boards_params)
  end
  
  def show
    @posts = @board.posts
#    @comments = @posts.comments
    @allboard = Board.all.includes(posts: :comments)
    @thisboard = @allboard.find(params[:id])
  end
  
  
  private
    def boards_params
      params.require(:board).permit(:board_url,:board_title,:board_content)
    end
    
    def set_board
      @board = Board.find(params[:id])
    end

end