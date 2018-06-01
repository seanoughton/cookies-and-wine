class CookiesController < ApplicationController

  def index
  end


  def new
    @cookie = Cookie.new
  end

  def create
    @cookie = Cookie.new(cookie_params)
    @cookie.user = current_user
    @cookie.save
    redirect_to @cookie
  end

  def show
    @cookie = Cookie.find(params[:id])
  end


  def update
  end

  def delete
  end

  private
  def cookie_params
    params.require(:cookie).permit(:name, :description, :link)
  end

end
