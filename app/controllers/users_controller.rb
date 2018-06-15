class UsersController < ApplicationController

  before_action :current_user
  before_action :run_permission, only: [:edit, :update, :destroy]

  def index
    @users = User.find_each
  end

  def new
    @user = User.new
  end

  def create #signup
    @user = User.new(user_params)
    validate_instance_and_redirect(@user,@user,"new")
=begin
    if @user.valid?
      @user.save
      log_in(@user)
      redirect_to controller: 'welcome', action: 'home'
    else
      render :new
    end
=end
  end

  def show
    return_instance_if_it_exists(User,params[:id])
  end

  def edit
    return_instance_if_it_exists(User,params[:id]) if params[:id]
    if @user && !@user.permission_to_edit?(current_user)
      redirect_to controller: 'sessions', action: 'new'
    end
  end

  def update
    return_instance_if_it_exists(User,params[:id]) if params[:id]

    redirect_to controller: 'sessions', action: 'new' if !@user.permission_to_edit?(current_user)

    if @user.permission_to_edit?(current_user)
      @user.update(user_params)
      validate_instance_and_redirect(@user,@user,"edit")
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :zipcode, :email, :password, :password_confirmation)
  end
end
