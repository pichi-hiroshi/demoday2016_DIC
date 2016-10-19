class LikesController < ApplicationController
    
  def create
    @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
    @likes = Like.where(post_id: params[:post_id])
    @post = current_user.posts.build(post_params)
    @posts = Post.all
    @board = @post.board
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    like.destroy
    @likes = Like.where(post_id: params[:post_id])
    @posts = Post.all
  end

  private
    def post_params
      params.require(:post).permit(:title,:message,:board_id,:avatar)
    end
end
