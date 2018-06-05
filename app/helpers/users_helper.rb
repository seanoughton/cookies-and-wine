module UsersHelper
  def user_admin?
    @user.admin?
  end
end
