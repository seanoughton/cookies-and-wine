class UsersController < ApplicationController

  before_action :current_user
  before_action :run_permission, only: [:edit, :update, :destroy]

  def index
    @users = User.find_each
  end

  def new
    @user = User.new
    @show_password = true
  end

  def create
    @user = User.new(user_params)
    @show_password = true
    validate_instance_and_redirect(@user,@user,"new",true)
  end

  def show
    return_instance_if_it_exists(User,params[:id])
  end

  def edit
    return_instance_if_it_exists(User,params[:id]) if params[:id]
    show_password(@user) #RETURNS TRUE OR FALSE TO SHOW THE PASSWORD ON THE EDIT PAGE
  end

  def update
    return_instance_if_it_exists(User,params[:id]) if params[:id]
    @user.update(user_params)
    validate_instance_and_redirect(@user,@user,"edit",false)
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
