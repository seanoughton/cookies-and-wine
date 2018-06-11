class CookiesController < ApplicationController
  before_action :require_logged_in
  before_action :current_user

  def index
    get_all_cookies
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
    find_cookie(params[:id])
    get_all_cookies
    @pairing = Pairing.new(cookie_id: params[:id])
  end

  def edit
    find_cookie(params[:id])
  end

  def update
    find_cookie(params[:id])
    @cookie.update(cookie_params)
    redirect_to @cookie
  end

  def destroy
    Pairing.delete_associated_pairings_for_cookie(params[:id])
    find_cookie(params[:id]).destroy
    redirect_to cookies_url
  end

  #HELPERS
  def find_cookie(id)
    @cookie = Cookie.find(id)
  end

  def get_all_cookies
    @cookies = Cookie.all
  end

  private
  def cookie_params
    params.require(:cookie).permit(:cookie_name, :description, :link, :user_id)
  end

end
