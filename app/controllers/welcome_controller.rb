class WelcomeController < ApplicationController
  before_action :require_logged_in
  before_action :current_user

  def index
  end
  def home
    @user = User.find(session[:user_id])
    @highest_rated_pairing = Pairing.highest_rated
    @most_commented_pairing = Pairing.most_commented
    @newest_pairing = Pairing.newest
    @oldest_pairing = Pairing.oldest
    @random_pairing = Pairing.find(rand(1...Pairing.last.id))
  end

end
