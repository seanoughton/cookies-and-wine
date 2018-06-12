class WinesController < ApplicationController
  before_action :require_logged_in
  before_action :current_user

  def index
    get_all_wines
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
    find_wine(params[:id])
    @pairing = Pairing.new(wine_id: params[:id])
  end

  def edit
    find_wine(params[:id])
  end


  def update
    find_wine(params[:id])
    @wine.update(wine_params)
    redirect_to @wine if @wine.valid?
    render :edit if !@wine.valid?
  end

  def destroy
    Pairing.delete_associated_pairings_for_wine(params[:id])
    Wine.find(params[:id]).destroy
    redirect_to wines_url
  end

  #HELPERS
  def find_wine(id)
    @wine = Wine.find(id)
  end

  def get_all_wines
    @wines = Wine.find_each
  end

  private
  def wine_params
    params.require(:wine).permit(:wine_name, :description, :origin, :grape_varietal, :user_id)
  end

end
