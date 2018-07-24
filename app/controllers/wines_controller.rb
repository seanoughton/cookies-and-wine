class WinesController < ApplicationController
  before_action :require_logged_in
  before_action :current_user
  before_action :run_permission, only: [:edit, :update, :destroy]

  def index
    @wines = Wine.get_wines(params)
    return_instance_if_it_exists(User,params[:user_id]) if params[:user_id]
  end


  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.new(wine_params)
    validate_instance_and_redirect(@wine,@wine,"new")
  end

  def show
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
