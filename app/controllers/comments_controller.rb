class CommentsController < ApplicationController
  before_action :require_logged_in
  before_action :current_user

  def index
    get_all_instance_variables(params)
    get_comments(params)
  end

  def new
    return_instance_if_it_exists(Pairing,params[:pairing_id])
    @comment = Comment.new(pairing_id: params[:pairing_id])
  end

  def create
    @comment = Comment.new(comment_params)
    return_instance_if_it_exists(Pairing,params[:comment][:pairing_id])
    validate_instance_and_redirect(@comment,@pairing,"new")
  end

  def show
    get_all_instance_variables(params)
    return_instance_if_it_exists(Comment,params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
    return_instance_if_it_exists(Pairing,params[:id])
  end

  def update
    return_instance_if_it_exists(Pairing,params[:id])
    Comment.find(params[:id]).update(comment_params)
    validate_instance_and_redirect(Comment.find(params[:id]),@pairing,"edit")
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
