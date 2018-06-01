class PairingsController < ApplicationController

  def index
    @pairings = Pairing.all
  end

  def new
    @pairing = Pairing.new
  end

  def create
    @pairing = Pairing.new(pairing_params)
    @pairing.user = current_user
    @pairing.save
    redirect_to @pairing
  end

  def show
     @pairing = Pairing.find(params[:id])
     @pairings = Pairing.all
  end

  def update
  end

  def destroy
  end

  private

  def pairing_params
    params.require(:pairing).permit(:rating, :cookie_id, :wine_id)
  end

end
