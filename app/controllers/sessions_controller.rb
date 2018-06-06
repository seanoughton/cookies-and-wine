class SessionsController < ApplicationController

  def new

  end

  def create
    byebug
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.user_name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
    end

    session[:user_id] = @user.id

    render 'welcome/home'
  end


=begin
  def create #login directly
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
=end
  def destroy
    session.delete :user_id
    redirect_to '/'
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
