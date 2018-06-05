class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create #signup
    #@user = User.create(user_params)
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

  end

  private

  def user_params
    params.require(:user).permit(:user_name, :zipcode, :email, :password, :password_confirmation)
  end
end
