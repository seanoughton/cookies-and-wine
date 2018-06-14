class PairingsController < ApplicationController
  before_action :require_logged_in
  before_action :current_user

  def index
    check_for_user_by_id(params[:user_id]) if params[:user_id]
    check_for_wine_by_id(params[:wine_id]) if params[:wine_id]
    check_for_cookie_by_id(params[:cooky_id]) if params[:cooky_id]
    get_pairings(params)
  end

  def sort
    @sorted_pairings = Pairing.sort_order(params[:sort])
    if params[:cookie]
      @cookie = Cookie.find(params[:cookie])
      @pairings = @sorted_pairings.select do |pairing|
        pairing.cookie == @cookie
      end
    elsif params[:wine]
      @wine = Wine.find(params[:wine])
      @pairings = @sorted_pairings.select do |pairing|
        pairing.wine == @wine
      end
    elsif params[:user]
      @user = User.find(params[:user])
      @pairings = @sorted_pairings.select do |pairing|
        pairing.user == @user
      end
    else
      @pairings = @sorted_pairings
    end
    render :index
  end

  def new
    if params[:cooky_id]
      @cookie = Cookie.find(params[:cooky_id])
    elsif params[:wine_id]
      @wine = Wine.find(params[:wine_id])
    else
    end
    @pairing = Pairing.new
  end

  def create
    @pairing = Pairing.new(pairing_params)
    if @pairing.valid?
      @pairing.save
      redirect_to @pairing
    else
      render :new
    end

  end

  def show
    check_for_pairing_by_id(params[:id])
    check_for_user_by_id(params[:user_id]) if params[:user_id]
    check_for_wine_by_id(params[:wine_id]) if params[:wine_id]
    check_for_cookie_by_id(params[:cooky_id]) if params[:cooky_id]
  end

  def edit
    @pairing = Pairing.find(params[:id])
  end

  def update
    @pairing = Pairing.new(pairing_params)
    #THE VALIDATION IS DONE THIS WAY, BECAUSE WHEN YOU UPDATE THE PAIRING WITH THE NEW INPUTS AND IT IS SAVED TO THE DATABASE,AND THEN YOU CHECK TO SEE IF IT IS VALID, IT WILL COME BACK AS INVALID, BECAUSE THE PAIRING EXISTS, WHICH CAUSES A VALIDATION ERROR
    if @pairing.valid?
      @pairing = Pairing.find(params[:id])
      @pairing.update(pairing_params)
      redirect_to @pairing
    else
      render :edit
    end
  end

  def destroy
    @pairing = Pairing.find(params[:id])
    @pairing.destroy
    redirect_to pairings_url
  end

  #HELPERS



  private

  def pairing_params
    params.require(:pairing).permit(:cookie_id, :wine_id, :user_id, :user_rating)
  end

end
