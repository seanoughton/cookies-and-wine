class WinesController < ApplicationController

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
  end


  def update
  end

  def delete
  end

  private
  def wine_params
    params.require(:wine).permit(:wine_name, :description, :origin, :grape_varietal)
  end

end
