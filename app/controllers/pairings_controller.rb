class PairingsController < ApplicationController
  before_action :require_logged_in
  before_action :current_user

  def index
    @pairings = Pairing.all
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
    if @pairing.valid?
      @pairing.save
      redirect_to @pairing
    else
      render :new
    end

  end

  def show
    find_pairing(params[:id])
    @comments = Comment.all
  end

  def edit
    find_pairing(params[:id])
  end

  def update
    @pairing = Pairing.new(pairing_params)
    #THE VALIDATION IS DONE THIS WAY, BECAUSE WHEN YOU UPDATE THE PAIRING WITH THE NEW INPUTS AND IT IS SAVED TO THE DATABASE,AND THEN YOU CHECK TO SEE IF IT IS VALID, IT WILL COME BACK AS INVALID, BECAUSE THE PAIRING EXISTS, WHICH CAUSES A VALIDATION ERROR
    if @pairing.valid?
      find_pairing(params[:id])
      @pairing.update(pairing_params)
      redirect_to @pairing
    else
      render :edit
    end
  end

  def destroy
    find_pairing(params[:id])
    @pairing.delete_pairings_comments_ratings
    find_pairing(params[:id]).destroy
    redirect_to pairings_url
  end



  #HELPERS
  def find_pairing(id)
    @pairing = Pairing.find(id)
  end


  private

  def pairing_params
    params.require(:pairing).permit(:cookie_id, :wine_id, :user_id, :user_rating)
  end

end
