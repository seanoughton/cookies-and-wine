module UsersHelper
  def user_admin?
    @current_user.admin?
  end

  def current_user?
    User.find_by(id: session[:user_id])
  end

  def user_current_user?
    @user == @current_user
  end

  def current_user_created_this_item?(item)
    item.user_id == @current_user.id
  end

  def delete(item)
    if user_admin?
      link_to "Delete", item, method: :delete, data: {confirm: "Really?!"}
    end
  end

  def edit(item)
    if current_user_created_this_item?(item) || user_admin?
        link_to "Edit", :controller => "#{item.class.to_s.downcase}s", :action => "edit", :id => item
    end
  end

end
