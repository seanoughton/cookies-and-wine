class UsersController < ApplicationController

  before_action :current_user #loads in the current_user

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create #signup
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to controller: 'welcome', action: 'home'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
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
      render :show
    else
      redirect_to controller: 'sessions', action: 'new'
    end

  end

  private

  def user_params
    params.require(:user).permit(:user_name, :zipcode, :email, :password, :password_confirmation)
  end
end
