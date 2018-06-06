class WinesController < ApplicationController
  before_action :require_logged_in
  def index
    @wines = Wine.all
  end


  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.new(wine_params)
    if @wine.valid?
      @wine.save
      redirect_to @wine
    else
      render :new
    end

  end

  def show
    @wine = Wine.find(params[:id])
    @wines = Wine.all
    @pairing = Pairing.new(wine_id: params[:id])
    @user = current_user
  end


  def update
  end

  def destroy
    Pairing.delete_associated_pairings_for_wine(params[:id])
    Wine.find(params[:id]).destroy
    redirect_to wines_url
  end

  private
  def wine_params
    params.require(:wine).permit(:wine_name, :description, :origin, :grape_varietal)
  end

end
