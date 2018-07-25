class PairingsController < ApplicationController
  before_action :require_logged_in
  before_action :current_user
  before_action :run_permission, only: [:edit, :update, :destroy]

  def index
    @pairings = Pairing.get_pairings(params)
    return_instance_if_it_exists(User,params[:user_id]) if params[:user_id]
    respond_to do |format|
      format.html { render :index }
      #format.json { render json: @pairings.to_json}
      format.json { render json: @pairings}
    end
  end

  def sort
    @pairings = Pairing.sort_order(params[:sort])
    render :index
  end

  def new
    @pairing = Pairing.new(cookie_id: params[:cooky_id],wine_id: params[:wine_id])
    #@pairing = Pairing.new
    return_instance_if_it_exists(Cookie,params[:cooky_id]) if params[:cooky_id]
    return_instance_if_it_exists(Wine,params[:wine_id]) if params[:wine_id]
  end

  def create
    @pairing = Pairing.new(pairing_params)
    validate_instance_and_redirect(@pairing,@pairing,"new")
  end

  def show
    return_instance_if_it_exists(Pairing,params[:id])
  end

  def edit
    @pairing = Pairing.find(params[:id])
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
