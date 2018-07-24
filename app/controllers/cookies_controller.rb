class CookiesController < ApplicationController
  before_action :require_logged_in
  before_action :current_user
  before_action :run_permission, only: [:edit, :update, :destroy]

  def index
    @cookies = Cookie.get_cookies(params)
    return_instance_if_it_exists(User,params[:user_id]) if params[:user_id]
  end

  def new
    @cookie = Cookie.new
  end

  def create
    @cookie = Cookie.new(cookie_params)
    validate_instance_and_redirect(@cookie,@cookie,"new")
  end

  def show
    return_instance_if_it_exists(Cookie,params[:id])
  end

  def edit
    return_instance_if_it_exists(Cookie,params[:id])
  end

  def update
    return_instance_if_it_exists(Cookie,params[:id])
    @cookie.update (cookie_params)
    validate_instance_and_redirect(@cookie,@cookie,"edit")
  end

  def destroy
    return_instance_if_it_exists(Cookie,params[:id])
    @cookie.destroy
    redirect_to cookies_url
  end



  private
  def cookie_params
    params.require(:cookie).permit(:cookie_name, :description, :link, :user_id)
  end

end
