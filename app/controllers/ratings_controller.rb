class RatingsController < ApplicationController

  before_action :require_logged_in
  before_action :current_user

  def new
    @rating = Rating.new(pairing_id: params[:pairing_id]) if params[:pairing_id]
    return_instance_if_it_exists(Pairing,params[:pairing_id]) if params[:pairing_id]
  end

  def create
    check_for_pairing_by_id(params[:rating][:pairing_id])
    @pairing.update_rating
    validate_instance_and_redirect(Rating.new(rating_params),@pairing,"new")
  end

private
  def rating_params
    params.require(:rating).permit(:rating_value, :pairing_id, :user_id)
  end
end
