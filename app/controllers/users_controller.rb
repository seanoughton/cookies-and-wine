class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create #signup
    @user = User.create(user_params)
    return redirect_to controller: 'users', action: 'new' unless @user.save
    #if it can't be saved then the password and password_confirmation did not match
    session[:user_id] = @user.id
    redirect_to controller: 'welcome', action: 'home'

  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password, :password_confirmation)
  end
end
