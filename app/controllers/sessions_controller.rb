class SessionsController < ApplicationController

  def new

  end

  def create
    if params[:code]
      facebook_login(params)
      redirect_the_user(@user)
    else
      regular_login(params)
      redirect_the_user(@user)
    end

  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

  #HELPERS
  def facebook_login(params)
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.user_name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
      u.password = SecureRandom.urlsafe_base64#create random password for facebook login
    end
  end

  def regular_login(params)
    @user = User.find_by(user_name: params[:user][:user_name])
    @user = @user.try(:authenticate, params[:user][:password])
    #try will return nil if it cannot authenticate, and then make @user nil
  end

  def redirect_the_user(user)
    if !user
      redirect_to(controller: 'sessions', action: 'new')
    else
      log_in(user)
      redirect_to(controller: 'welcome', action: 'home')
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
