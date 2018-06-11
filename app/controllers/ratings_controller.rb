class RatingsController < ApplicationController

  before_action :require_logged_in
  before_action :current_user

  def new
    if !Pairing.exists?(params[:pairing_id])
      redirect_to pairings_path, alert: "Pairing not found."
    else
      @rating = Rating.new(pairing_id: params[:pairing_id])
      @pairing = Pairing.find(params[:pairing_id])
    end
  end

  def create
    params[:rating][:user_id] = current_user.id
    @rating = Rating.new(rating_params)
    if @rating.valid?
      @rating.save
      update_pairing_rating(params[:rating][:pairing_id])
      redirect_to pairing_path(@pairing)
    else
      render :new
    end
  end


  #HELPERS
  def update_pairing_rating(pairing_id)
    @pairing = Pairing.find(pairing_id)
    @pairing.update_rating
  end

private
  def rating_params
    params.require(:rating).permit(:rating_value, :pairing_id, :user_id)
  end
end
