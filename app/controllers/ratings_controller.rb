class RatingsController < ApplicationController

  before_action :require_logged_in
  before_action :current_user

  def new
    check_for_pairing_by_id(params[:pairing_id])
    @rating = Rating.new(pairing_id: params[:pairing_id]) if params[:pairing_id]
  end

  def create
    @rating = Rating.new(rating_params)
    check_for_pairing_by_id(params[:rating][:pairing_id])
    @pairing.update_rating
    validate_instance_and_redirect(@rating,@pairing,"new")
  end

private
  def rating_params
    params.require(:rating).permit(:rating_value, :pairing_id, :user_id)
  end
end
