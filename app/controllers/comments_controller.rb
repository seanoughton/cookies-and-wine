class CommentsController < ApplicationController
  before_action :require_logged_in
  before_action :current_user
  before_action :run_permission, only: [:update, :destroy]

  def index
    @comments = Comment.get_comments(params)
    return_instance_if_it_exists(User,params[:user_id]) if params[:user_id]
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @comments.to_json}
    end
  end

  def new
    @comment = Comment.new(pairing_id: params[:pairing_id])
    return_instance_if_it_exists(Pairing,params[:pairing_id]) if params[:pairing_id]
  end

  def create
    @comment = Comment.new(comment_params)
    @pairing = Pairing.find(params[:comment][:pairing_id])
    validate_instance_and_redirect(@comment,@pairing,"new")
  end

  def show
    return_instance_if_it_exists(Comment,params[:id])
  end

  def edit
    return_instance_if_it_exists(Comment,params[:id])
  end

  def update
    Comment.find(params[:id]).update(comment_params)
    validate_instance_and_redirect(Comment.find(params[:id]),Comment.find(params[:id]),"edit")
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to comments_url
  end


  private

  def comment_params
    params.require(:comment).permit(:body, :pairing_id, :user_id)
  end
end
