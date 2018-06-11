module UsersHelper

  #RETURNS TRUE IF THE CURRENT USER IS AN ADMIN
  def user_admin?
    @current_user.admin?
  end

  #THIS IS HERE SO THAT WHEN A LOGGED IN USER NAVIGATES TO ANOTHER USERS PROFILE PAGE, THEY CANNOT EDIT THEIR PROFILE
  #IS THE LOGGED IN USER THE SAME USER FOR ANY GIVEN PROFILE PAGE
  def user_current_user?
    @user == @current_user
  end

  #THIS IS HERE SO THAT COMMENTS,COOKIES,PAIRINGS,WINES CAN BE EDITED BY THE USER THAT CREATED THEM
  def current_user_created_this_item?(item)
    item.user_id == @current_user.id
  end



end
