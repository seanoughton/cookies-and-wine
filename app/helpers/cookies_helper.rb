module CookiesHelper



  def edit(item)
    if user_current_user? || user_admin?
      link_to "Edit", edit_comment_url(comment)
    end
  end

end
