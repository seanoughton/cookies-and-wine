module UsersHelper
  def user_admin?
    @user.admin?
  end

  def user_current_user?
    #is the current user the one who created the thing (comment,etc)
    @comment.user_id == @user.id
  end
end
