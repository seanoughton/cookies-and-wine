class CookiesController < ApplicationController
  before_action :require_logged_in
  before_action :current_user
  def index
    @cookies = Cookie.all
  end


  def new
    @cookie = Cookie.new
  end

  def create
    @cookie = Cookie.new(cookie_params)
    if @cookie.valid?
      @cookie.save
      redirect_to @cookie
    else
      render :new
    end
  end

  def show
    @cookie = Cookie.find(params[:id])
    @cookies = Cookie.all
    @pairing = Pairing.new(cookie_id: params[:id])
    @user = current_user
  end

  def edit
    @cookie = Cookie.find(params[:id])
  end

  def update
    @cookie = Cookie.find(params[:id])
    @cookie.update(cookie_params)
    redirect_to @cookie
  end

  def destroy
    Pairing.delete_associated_pairings_for_cookie(params[:id])
    Cookie.find(params[:id]).destroy
    redirect_to cookies_url
  end

  private
  def cookie_params
    params.require(:cookie).permit(:cookie_name, :description, :link, :user_id)
  end

end
