class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  #RETURNS THE CURRENTLY LOGGED IN USER
  def current_user
    @current_user = (User.find_by(id: session[:user_id]) || User.new)
  end

  #RETURNS TRUE/FALSE IF USER IS LOGGED IN OR NOT
  def logged_in?
    current_user.id != nil
  end

  #LOGS THE USER IN
  def log_in(user)
    session[:user_id] = user.id
  end

  #RE-ROUTES THE USER TO THE LOGIN PAGE IF THEY ARE NOT LOGGED IN
  def require_logged_in
    return redirect_to(controller: 'sessions', action: 'new') unless logged_in?
  end

  #LOG IN HELPERS

  #EITHER REDIRECTS USER TO LOGIN PAGE OR LOGS THE USER IN AND REDIRECTS THE USER TO THE USER'S PROFILE PAGE
  def redirect_the_user(user)
    if !user
      redirect_to(controller: 'sessions', action: 'new')
    else
      log_in(user)
      redirect_to "/home"
    end
  end

  #LOGS THE USER IN WITH OMNIAUTH THROUGH FACEBOOK
  def facebook_login(params)
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.user_name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
      u.password = SecureRandom.urlsafe_base64#create random password for facebook login
    end
    redirect_the_user(@user)
  end

  #LOGS THE USER IN WITH USER NAME AND PASSWORD
  #AUTHENTICATES USER NAME AND PASSWORD
  def regular_login(params)
    @user = User.find_by(user_name: params[:user][:user_name])
    @user = @user.try(:authenticate, params[:user][:password])
    #try will return nil if it cannot authenticate, and then make @user nil
    redirect_the_user(@user)
  end


#REDIRECTS IF PAIRING ISN'T FOUND
  def check_for_pairing_by_id(id)
    @pairing = Pairing.return_pairing(id)
    redirect_to pairings_path, alert: "Pairing not found." if !Pairing.return_pairing(id)
  end

#RETURNS ANY TYPE OF CLASS INSTANCE AND CHECKS IF IT EXISTS FIRST
#IF INSTANCE ISN'T FOUND, REDIRECTS USER WITH ALERT
#WORKS WITH Class Name and  params[:id]
  def return_instance_if_it_exists(class_name,id)
    #EDGE CASE: PAIRINGS HAVE SORT PARAMETERS, THIS CODE ACCOUNT FOR THE SORT PARAMETERS
    if class_name.to_s == "Pairing"
      check_for_pairing_by_id(id)
    elsif id == "most_pairings"
        @user = User.most_pairings
    else
      instance_variable_set("@#{class_name.to_s.downcase}", class_name.find(id) ) if class_name.exists?(id)
      redirect_to "/#{class_name.to_s.downcase}s", alert: "#{class_name} not found." if !class_name.exists?(id)
    end
  end


  #CHECKS TO SEE IF AN INSTANCE IS VALID AND REDIRECTS
  def validate_instance_and_redirect(instance,redirect_route,render_route,login=false)#login is an optional argument.  If a user is being created or if an already exisiting user is being validated then the login parameter is submitted.
    if instance.valid?
      instance.save

      #EDGE CASE: CREATES A BASE RATING OF 1 FOR ANY PAIRING THAT IS CREATED. PREVENTS A PAIRING FROM BEING CREATED WITHOUT A USER RATING.
      if instance == @pairing
        @rating = Rating.create(rating_value: 1, pairing_id: @pairing.id, user_id: current_user.id)
      end

      #EDGE CASE: THIS IS FOR WHEN A USER IS CREATED AND THE USER IS VALID
      log_in(instance) if login == true

      redirect_to redirect_route
    else
      render render_route
    end
  end

  #CHECKS THE PERMISSIONS FOR THE USER
  def run_permission
    #this turns the controller name into a model name, ex. comments_controller becomes "Comment"
    model = params[:controller].to_s.chop.titlecase

    #this returns and instance of a Class based on the params[:id]
    #the instance is the the thing that the user wants to change
    #we are checking to see if the user has permission to change it
    instance = model.camelize.constantize.find(params[:id])
    #camelize converts a string from snake case to camel case
    #constantize turns a string into a constant, ex. "Comment" becomes Comment, in this case, it turns it into a Class
    #ex. instance = Comment.find(params[:id])

    redirect_to current_user, alert: "You do not have permission to do this." if !current_user.user_permission(instance,current_user)
  end



end
