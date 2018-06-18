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

  #LOG IN HELPERS
  def facebook_login(params)
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.user_name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
      u.password = SecureRandom.urlsafe_base64#create random password for facebook login
    end
    redirect_the_user(@user)
  end

  def regular_login(params)
    @user = User.find_by(user_name: params[:user][:user_name])
    @user = @user.try(:authenticate, params[:user][:password])
    #try will return nil if it cannot authenticate, and then make @user nil
    redirect_the_user(@user)
  end

  def redirect_the_user(user)
    if !user
      redirect_to(controller: 'sessions', action: 'new')
    else
      log_in(user)
      redirect_to "/home"
    end
  end


#REDIRECTS IF PAIRING ISN'T FOUND
  def check_for_pairing_by_id(id)
    @pairing = Pairing.return_pairing(id)
    redirect_to pairings_path, alert: "Pairing not found." if !Pairing.return_pairing(id)
  end

#RETURNS ANY TYPE OF CLASS INSTANCE AND CHECKS IF IT EXISTS FIRST
#WORKS WITH Class Name and  params[:id]
  def return_instance_if_it_exists(class_name,id)
    #PAIRINGS HAVE SORT PARAMETERS, THIS CODE ACCOUNT FOR THE SORT PARAMETERS
    if class_name.to_s == "Pairing"
      check_for_pairing_by_id(id)
    elsif id == "most_pairings"
        @user = User.most_pairings
    else
      instance_variable_set("@#{class_name.to_s.downcase}", class_name.find(id) ) if class_name.exists?(id)
      redirect_to "/#{class_name.to_s.downcase}s", alert: "#{class_name} not found." if !class_name.exists?(id)
    end
  end

  #RETURNS Instance variables with the parent_id
  #WORKS WITH Class Name and  params[:parent_id]
  #Looks in the params and creats any instances that are needed for a specific action based on the params[:parent_id]
  def get_all_instance_variables#(params)
    return_instance_if_it_exists(User,params[:user_id]) if params[:user_id]
    return_instance_if_it_exists(Pairing,params[:pairing_id]) if params[:pairing_id]
    return_instance_if_it_exists(Cookie,params[:cooky_id]) if params[:cooky_id]
    return_instance_if_it_exists(Wine,params[:wine_id]) if params[:wine_id]
    Pairing.get_pairings(params)
    return_instance_if_it_exists(Comment,params[:comment_id]) if params[:comment_id]
  end


  def validate_instance_and_redirect(instance,redirect_route,render_route,login=false)
    if instance.valid?
      instance.save

      #EDGE CASE
      if instance == @pairing
        @rating = Rating.create(rating_value: 1, pairing_id: @pairing.id, user_id: current_user.id)
      end

      #EDGE CASE
      log_in(instance) if login == true

      redirect_to redirect_route
    else
      render render_route
    end
  end

  #CHECKS THE PERMISSIONS FOR THE USER
  def run_permission
    model = params[:controller].to_s.chop.titlecase
    #converts the string to a class
    instance = model.camelize.constantize.find(params[:id])
    redirect_to current_user, alert: "You do not have permission to do this." if !current_user.user_permission(instance,current_user)
  end

  #DETERMINES IF THE USER EDIT PAGE WILL SHOW A PASSWORD OR NOT
  def show_password(user)
    @show_password = true
    @show_password = false if (current_user.admin && !user.admin) || user.uid
    @show_password
  end


end
