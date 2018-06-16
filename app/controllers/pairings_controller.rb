class PairingsController < ApplicationController
  before_action :require_logged_in
  before_action :current_user
  before_action :run_permission, only: [:edit, :update, :destroy]
  before_action :get_all_instance_variables, only: [:index, :new, :show]

  def index
    get_pairings(params)
  end

  def sort
    @pairings = Pairing.sort_order(params[:sort])
    render :index
  end

  def new
    @pairing = Pairing.new
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
    @pairing = Pairing.find(params[:id])
    @pairing.destroy
    redirect_to pairings_url
  end


  private

  def pairing_params
    params.require(:pairing).permit(:cookie_id, :wine_id, :user_id, :user_rating)
  end

end
