class PairingsController < ApplicationController
  before_action :require_logged_in
  before_action :current_user
  before_action :run_permission, only: [:edit, :update, :destroy]

  def index
    if params[:sort]
      @pairings = Pairing.sort_order(params[:sort])
    else
      @pairings = Pairing.get_pairings(params)
      return_instance_if_it_exists(User,params[:user_id]) if params[:user_id]
    end
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @pairings}
    end
  end
=begin
  def sort
    @pairings = Pairing.sort_order(params[:sort])
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @pairings}
    end

  end
=end
  def new
    @pairing = Pairing.new
    return_instance_if_it_exists(Cookie,params[:cooky_id]) if params[:cooky_id]
    return_instance_if_it_exists(Wine,params[:wine_id]) if params[:wine_id]
  end

  def create
    @pairing = Pairing.new(pairing_params)
    validate_instance_and_redirect(@pairing,@pairing,"new")
  end

  def show
    return_instance_if_it_exists(Pairing,params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @pairing}
    end
  end

  def edit
    @pairing = Pairing.find(params[:id])
    @cookie = Cookie.find(@pairing.cookie_id)
    @wine = Wine.find(@pairing.wine_id)
  end

  def update
    return_instance_if_it_exists(Pairing,params[:id])
    @pairing.update(pairing_params)
    validate_instance_and_redirect(@pairing,@pairing,"edit")
  end

  def destroy
    return_instance_if_it_exists(Pairing,params[:id])
    @pairing.destroy
    redirect_to pairings_url
  end


  private

  def pairing_params
    params.require(:pairing).permit(:cookie_id, :wine_id, :user_id, :user_rating)
  end

end
