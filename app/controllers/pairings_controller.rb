class PairingsController < ApplicationController
  before_action :require_logged_in

  def index
    @pairings = Pairing.all
  end

  def sort
    case params[:sort]
    when "highest rated"
      @pairings = Pairing.highest_to_lowest
    when "lowest rated"
      @pairings = Pairing.lowest_to_highest
    when "most commented"
      @pairings = Pairing.most_commented_list
    when "newest"
      @pairings = Pairing.newest_list
    when "oldest"
      @pairings = Pairing.oldest_list
    else
      @pairings = Pairing.all
    end
    render :index
  end

  def new
    @pairing = Pairing.new
  end

  def create
    @pairing = Pairing.new(pairing_params)
    @pairing.user = current_user
    if @pairing.valid?
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

  #helper methods



  private

  def pairing_params
    params.require(:pairing).permit(:cookie_id, :wine_id)
  end

end
