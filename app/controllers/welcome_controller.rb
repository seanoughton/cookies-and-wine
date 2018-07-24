class WelcomeController < ApplicationController
  before_action :require_logged_in
  before_action :current_user

  def home
    
  end

end
