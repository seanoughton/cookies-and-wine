class WinesController < ApplicationController
  before_action :require_logged_in
  before_action :current_user
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

  def edit
    @wine = Wine.find(params[:id])
  end


  def update
    @wine = Wine.find(params[:id])
    @wine.update(wine_params)
    redirect_to @wine
  end

  def destroy
    Pairing.delete_associated_pairings_for_wine(params[:id])
    Wine.find(params[:id]).destroy
    redirect_to wines_url
  end

  private
  def wine_params
    params.require(:wine).permit(:wine_name, :description, :origin, :grape_varietal, :user_id)
  end

end
