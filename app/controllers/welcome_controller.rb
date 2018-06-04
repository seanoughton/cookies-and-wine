class WelcomeController < ApplicationController
  before_action :require_logged_in
  def home
    @user = User.find(session[:user_id])
    @highest_rated_pairing = Pairing.highest_rated
    byebug
    @most_commented_pairing = Pairing.most_commented
  end

end
