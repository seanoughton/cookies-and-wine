class WelcomeController < ApplicationController
  before_action :require_logged_in
  def home
    @user = User.find(session[:user_id])
    @pairings = Pairing.all
    @cookies = Cookie.all
    @wines = Wine.all
  end

end
