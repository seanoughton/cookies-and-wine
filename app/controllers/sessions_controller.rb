class SessionsController < ApplicationController

  def new
    
  end

  def create #login
    user = User.find_by(user_name: params[:user][:user_name])
    user = user.try(:authenticate, params[:user][:password])
    #will make @user nil if the user cannot be authenticated with the username and password
    #try will return nil if it cannot authenticate, and then make @user nil

    return redirect_to(controller: 'sessions', action: 'new') unless user
    #return head(:forbidden) unless @user.authenticate(params[:user][:password])
    session[:user_id] = user.id #logs user in
    @user = user
    redirect_to controller: 'welcome', action: 'home'
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

end
