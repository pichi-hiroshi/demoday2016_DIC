class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。
  def create
    # ログインユーザーに紐付けてインスタンス生成するためbuildメソッドを使用します。
    @comment = current_user.comments.build(comment_params)
    @post = @comment.post

    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: 'コメントを投稿しました。' }
      else
        format.html { render :new }
      end
    end
  end
  
  # respond_toは、クライアントからの要求に応じてレスポンスのフォーマットを変更します。
  respond_to do |format|
    if @comment.save
      format.html { redirect_to post_path(@post), notice: 'コメントを投稿しました。' }
      format.json { render :show, status: :created, location: @comment }
      # JS形式でレスポンスを返します。
      format.js { render :index }
    else
      format.html { render :new }
      format.json { render json: @comment.errors, status: :unprocessable_entity }
    end
  end
  
  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:post_id, :content)
    end
end
