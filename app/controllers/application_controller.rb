class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  def current_user
    @current_user = (User.find_by(id: session[:user_id]) || User.new)
  end


  def logged_in?
    current_user.id != nil
  end

  def log_in(user) #LOGS THE USER IN
    session[:user_id] = user.id
  end

  def require_logged_in
    return redirect_to(controller: 'sessions', action: 'new') unless logged_in?
  end

  def is_current_user?(params_id)
    session[:user_id] == params_id.to_i
  end

  def check_for_user(params)
    if params[:id]
      params[:user_id] = params[:id]
    end
    if params[:user_id] && User.exists?(params[:user_id])
        @user = User.find(params[:user_id])
        @pairings = @user.pairings
        @comments = @user.comments
        @cookies = @user.cookies
        @wines = @user.wines
    elsif params[:user_id] && !User.exists?(params[:user_id])
        redirect_to users_path, alert: "User not found."
    end
  end


    def check_for_cookie(params)
      if params[:cooky_id] && Cookie.exists?(params[:cooky_id])
        @cookie = Cookie.find(params[:cooky_id])
        @pairings = @cookie.pairings
      elsif params[:cooky_id] && !Cookie.exists?(params[:cooky_id])
        redirect_to pairings_path, alert: "Cookie not found."
      end
    end

    def check_for_wine(params)
      if params[:wine_id] && Wine.exists?(params[:wine_id])
        @wine = Wine.find(params[:wine_id])
        @pairings = @wine.pairings
      elsif params[:wine_id] && !Wine.exists?(params[:wine_id])
        redirect_to pairings_path, alert: "Wine not found."
      end
    end

    def check_for_pairing(params)
      if params[:id]
        params[:pairing_id] = params[:id]
      end
      if params[:pairing_id] && Pairing.return_pairing(params[:pairing_id])
        @pairing = Pairing.return_pairing(params[:pairing_id])
        @comments = @pairing.comments
      elsif params[:pairing_id] && !Pairing.exists?(params[:pairing_id])
        redirect_to pairings_path, alert: "Pairing not found."
      end
    end


end
