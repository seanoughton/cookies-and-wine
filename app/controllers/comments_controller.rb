class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end
  def new
    if params[:pairing_id] && !Pairing.exists?(params[:pairing_id])
      redirect_to pairings_path, alert: "Pairing not found."
    else
      @comment = Comment.new(pairing_id: params[:pairing_id])
    end

  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.valid?
      @comment.save
      @pairing = Pairing.find(params[:comment][:pairing_id])
      @pairing.updated_comment_count
      redirect_to pairing_path(@pairing)
    else
      render :new
    end

  end

  def show
    @user = current_user
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    if @comment.valid?
      redirect_to comment_path(@comment)
    else
      render :edit
    end

  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

private

  def comment_params
    params.require(:comment).permit(:body, :pairing_id, :user_id)
  end
end
