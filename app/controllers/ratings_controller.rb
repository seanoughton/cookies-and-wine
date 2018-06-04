class RatingsController < ApplicationController


  def new
    if params[:pairing_id] && !Pairing.exists?(params[:pairing_id])
      redirect_to pairings_path, alert: "Pairing not found."
    else
      @rating = Rating.new(pairing_id: params[:pairing_id])
    end

  end

  def create
    @rating = Rating.new(rating_params)
    @rating.user = current_user
    @rating.save
    #at this point the pairing has had this rating added to it's collection of ratings
    #when you create a rating you have to update the pairings rating
    @pairing = Pairing.find(params[:rating][:pairing_id])
    #@pairing.ratings << @rating
    @pairing.updated_rating
    redirect_to pairing_path(@pairing)
  end

  def show
  end

  def rating_params
    params.require(:rating).permit(:rating_value, :pairing_id)
  end
end
