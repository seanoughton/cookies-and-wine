class PairingsController < ApplicationController
  before_action :require_logged_in
  def index
    @pairings = Pairing.all
    #@highest_to_lowest = Pairing.highest_to_lowest
    #@lowest_to_highest = Pairing.lowest_to_highest
    @highest_rated_pairing = Pairing.highest_rated
    @most_commented_pairing = Pairing.most_commented
    @newest_pairing = Pairing.newest
    @oldest_pairing = Pairing.oldest
  end

  def new
    @pairing = Pairing.new
  end

  def create
    @pairing = Pairing.new(pairing_params)
    @pairing.user = current_user
    if @pairing.valid?
      @pairing.comment_count = 0
      @pairing.user_rating = 1
      @pairing.save
      redirect_to @pairing
    else
      render :new
    end

  end

  def show
     @pairing = Pairing.find(params[:id])
     @pairings = Pairing.all
     @comments = Comment.all
     @user = current_user
  end

  def update
    byebug
    #store all of the ratings as an array and the average them
    @pairing = Pairing.find(params[:id])
    @rating = params[:pairing][:rating].to_i
    @pairing.rating = @pairing.rating + @rating
  end

  def destroy
    Pairing.find(params[:id]).destroy
    redirect_to pairings_url
  end

  private

  def pairing_params
    params.require(:pairing).permit(:cookie_id, :wine_id)
  end

end
