module UsersHelper
  def user_admin?
    @user.admin?
  end

  def user_current_user?(item)
    #is the current user the one who created the thing (comment,etc)
    item.user_id == @user.id
  end

  def delete(item)
    if user_admin?
      link_to "Delete", item, method: :delete, data: {confirm: "Really?!"}
    end
  end

  def edit(item)
    if user_current_user?(item) || user_admin?
        link_to "Edit", :controller => "#{item.class.to_s.downcase}s", :action => "edit", :id => item
    end
  end

end
