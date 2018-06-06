class SessionsController < ApplicationController

  def new

  end

  def create
    if params[:code] #if logging in with facebook
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.user_name = auth['info']['name']
        u.email = auth['info']['email']
        u.image = auth['info']['image']
        u.password = SecureRandom.urlsafe_base64
      end
    else #if logging in directly
        @user = User.find_by(user_name: params[:user][:user_name])
        @user = @user.try(:authenticate, params[:user][:password])
        #will make @user nil if the user cannot be authenticated with the username and password
        #try will return nil if it cannot authenticate, and then make @user nil
    end
    if !@user
      redirect_to(controller: 'sessions', action: 'new') #unless @user
    else
      session[:user_id] = @user.id #logs the user in
      redirect_to(controller: 'welcome', action: 'home')
    end

  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
