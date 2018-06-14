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

  def check_for_comment_by_id(id)
    @comment = Comment.find(id) if Comment.exists?(id)
    redirect_to comments_path, alert: "Comment not found." if !Comment.exists?(id)
  end

  def check_for_user_by_id(id)
    if id == "most_pairings"
      @user = User.most_pairings
    else
      @user = User.find(id) if User.exists?(id)
      redirect_to users_path, alert: "User not found." if !User.exists?(id)
    end
  end

  def check_for_pairing_by_id(id)
    @pairing = Pairing.return_pairing(id)
    redirect_to pairings_path, alert: "Pairing not found." if !Pairing.return_pairing(id)
  end

  def check_for_cookie_by_id(id)
    @cookie = Cookie.find(id) if Cookie.exists?(id)
    redirect_to cookies_path, alert: "Cookie not found." if !Cookie.exists?(id)
  end

  def check_for_wine_by_id(id)
    redirect_to wines_path, alert: "Wine not found." if !Wine.exists?(id)
    @wine = Wine.find(id) if Wine.exists?(id)
  end

  def get_pairings(params)
    if params[:wine_id] && Wine.exists?(params[:wine_id])
      @pairings = Wine.find(params[:wine_id]).pairings
    elsif params[:cooky_id] && Cookie.exists?(params[:cooky_id])
      @pairings = Cookie.find(params[:cooky_id]).pairings
    elsif params[:user_id] && User.exists?(params[:user_id])
      @pairings = User.find(params[:user_id]).pairings
    else
      @pairings = Pairing.find_each
    end
  end

  def get_comments(params)
    if params[:pairing_id] && Pairing.exists?(params[:pairing_id])
      @comments = Pairing.find(params[:pairing_id]).comments
    elsif params[:user_id] && User.exists?(params[:user_id])
      @comments = User.find(params[:user_id]).comments
    else
      @comments = Comment.find_each
    end
  end


end
