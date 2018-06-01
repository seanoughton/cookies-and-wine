class WinesController < ApplicationController

  def index
    @wines = Wine.all
  end


  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.create(wine_params)
    redirect_to @wine
  end

  def show
    @wine = Wine.find(params[:id])
    @wines = Wine.all
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
