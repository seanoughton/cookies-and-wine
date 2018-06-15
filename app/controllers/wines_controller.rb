class WinesController < ApplicationController
  before_action :require_logged_in
  before_action :current_user

  def index
    @wines = Wine.find_each
    get_all_instance_variables(params)
  end


  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.new(wine_params)
    validate_instance_and_redirect(@wine,@wine,"new")
  end

  def show
    get_all_instance_variables(params)
    return_instance_if_it_exists(Wine,params[:id])
  end

  def edit
    return_instance_if_it_exists(Wine,params[:id])
  end


  def update
    return_instance_if_it_exists(Wine,params[:id])
    @wine.update(wine_params)
    validate_instance_and_redirect(@wine,@wine,"edit")
  end

  def destroy
    return_instance_if_it_exists(Wine,params[:id])
    @wine.destroy
    redirect_to wines_url
  end


  private
  def wine_params
    params.require(:wine).permit(:wine_name, :description, :origin, :grape_varietal, :user_id)
  end

end
