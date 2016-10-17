module BoardsHelper
  def choose_new_or_edit_board
    if action_name == 'new' || action_name == 'confirm'
      confirm_boards_path
    elsif action_name == 'edit'
      board_path
    end
  end
  
  def createpost
#    cc = params[:id]
    link_to 'ポスト作成', new_post_path
  end
  
end
