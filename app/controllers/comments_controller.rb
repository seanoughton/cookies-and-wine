class CommentsController < ApplicationController
  before_action :current_user
  def index
    @comments = Comment.all
  end

  def new
    if params[:pairing_id] && !Pairing.exists?(params[:pairing_id])
      redirect_to pairings_path, alert: "Pairing not found."
    else
      @comment = Comment.new(pairing_id: params[:pairing_id])
      @pairing = Pairing.find(params[:pairing_id])
      #@user = current_user
    end

  end

  def create
    @comment = Comment.new(comment_params)
    @pairing = Pairing.find(params[:comment][:pairing_id])
    if @comment.valid?
      @comment.save
      redirect_to pairing_path(@pairing)
    else
      render :new
    end

  end

  def show
    #@user = current_user
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
    @pairing = @comment.pairing
    #@user = current_user
  end

  def update
    @comment = Comment.find(params[:id])
    @pairing = @comment.pairing
    @comment.update(comment_params)
    if @comment.valid?
      redirect_to comment_path(@comment)
    else
      render :edit
    end

  end

  def destroy
    comment = Comment.find(params[:id])
    @pairing = comment.pairing
    comment.destroy
    redirect_to @pairing
  end

private

  def comment_params
    params.require(:comment).permit(:body, :pairing_id, :user_id)
  end
end
