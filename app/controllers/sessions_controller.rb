class SessionsController < ApplicationController

  def create
    facebook_login(params) if params[:code]
    regular_login(params) if !params[:code]
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
