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

  def return_instance_if_it_exists(class_name,id)
    if class_name.to_s == "Pairing"
      check_for_pairing_by_id(id)
    elsif id == "most_pairings"
        @user = User.most_pairings
    else
      instance_variable_set("@#{class_name.to_s.downcase}", class_name.find(id) ) if class_name.exists?(id)
      redirect_to "/#{class_name.to_s.downcase}s", alert: "#{class_name} not found." if !class_name.exists?(id)
    end
  end

  def get_all_instance_variables(params)
    return_instance_if_it_exists(User,params[:user_id]) if params[:user_id]
    return_instance_if_it_exists(Pairing,params[:pairing_id]) if params[:pairing_id]
    return_instance_if_it_exists(Cookie,params[:cooky_id]) if params[:cooky_id]
    return_instance_if_it_exists(Wine,params[:wine_id]) if params[:wine_id]
    get_pairings(params)
    return_instance_if_it_exists(Comment,params[:comment_id]) if params[:comment_id]
  end

  def check_for_pairing_by_id(id)
    @pairing = Pairing.return_pairing(id)
    redirect_to pairings_path, alert: "Pairing not found." if !Pairing.return_pairing(id)
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

  def validate_instance_and_redirect(instance,redirect_route,render_route)
    if instance.valid?
      instance.save
      if instance == @user
        log_in(instance)
      end
      redirect_to redirect_route
    else
      render render_route
    end
  end

=begin
  def set_thread
    Thread.current[:current_user] = current_user
  end
=end
  def run_permission
    model = params[:controller].to_s.chop.titlecase
    #converts the string to a class
    instance = model.camelize.constantize.find(params[:id])
    redirect_to current_user, alert: "You do not have permission to do this." if !current_user.user_permission(instance,current_user)

=begin
    @cookie = Cookie.find(params[:id])
    redirect_to current_user, alert: "You do not have permission to do this." if !current_user.user_permission(@cookie,current_user)
=end
  end


end
