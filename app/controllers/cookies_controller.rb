class CookiesController < ApplicationController
  before_action :require_logged_in
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


  def update
  end

  def destroy
    Pairing.delete_associated_pairings_for_cookie(params[:id])
    Cookie.find(params[:id]).destroy
    redirect_to cookies_url
  end

  private
  def cookie_params
    params.require(:cookie).permit(:cookie_name, :description, :link)
  end

end
