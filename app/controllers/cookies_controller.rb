class CookiesController < ApplicationController

  def index
    @cookies = Cookie.all
  end


  def new
    @cookie = Cookie.new
  end

  def create
    @cookie = Cookie.create(cookie_params)
    redirect_to @cookie
  end

  def show
    @cookie = Cookie.find(params[:id])
    @cookies = Cookie.all
    @pairing = Pairing.new(cookie_id: params[:id])
  end


  def update
  end

  def delete
  end

  private
  def cookie_params
    params.require(:cookie).permit(:cookie_name, :description, :link)
  end

end
