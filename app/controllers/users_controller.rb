class UsersController < ApplicationController

  before_action :current_user

  def index
    @users = User.find_each
  end

  def new
    @user = User.new
  end

  def create #signup
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      log_in(@user)
      redirect_to controller: 'welcome', action: 'home'
    else
      render :new
    end
  end

  def show
    @user = User.return_user(params[:id])
    #@user = User.find(params[:id])
  end

  def edit
    if is_current_user?(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to controller: 'sessions', action: 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if is_current_user?(params[:id])
      @user.update(user_params)
      redirect_to @user if @user.valid?
      render :edit if !@user.valid?
    else
      redirect_to controller: 'sessions', action: 'new'
    end

  end

  private

  def user_params
    params.require(:user).permit(:user_name, :zipcode, :email, :password, :password_confirmation)
  end
end
