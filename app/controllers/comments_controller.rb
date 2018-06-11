class CommentsController < ApplicationController
  before_action :current_user #loads in the current_user

  def index
    @comments = Comment.all
  end

  def new #CREATES A COMMENT FOR A SPECIFIC PAIRING
    if !params[:pairing_id] || !Pairing.pairing_exists?(params[:pairing_id])
      redirect_to pairings_path, alert: "Pairing not found."
    else
      create_empty_comment(params[:pairing_id])
      find_pairing(params[:pairing_id])
    end

  end

  def create #CREATES A COMMENT FOR A SPECIFIC PAIRING
    @comment = Comment.new(comment_params)
    find_pairing(params[:comment][:pairing_id])
    if @comment.valid?
      @comment.save
      redirect_to pairing_path(@pairing)
    else
      render :new
    end

  end

  def show
    find_comment(params[:id])
  end

  def edit
    find_comment(params[:id])
    @pairing = @comment.pairing
  end

  def update
    find_comment(params[:id])
    @pairing = @comment.pairing
    @comment.update(comment_params)
    if @comment.valid?
      redirect_to comment_path(@comment)
    else
      render :edit
    end

  end

  def destroy
    find_comment(params[:id])
    @pairing = @comment.pairing
    @comment.destroy
    redirect_to @pairing
  end

  #helpers

  def find_pairing(pairing_id)
    @pairing = Pairing.find(pairing_id)
  end


  def find_comment(id)
    @comment = Comment.find(id)
  end

  def create_empty_comment(pairing_id)
    @comment = Comment.new(pairing_id: pairing_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :pairing_id, :user_id)
  end
end
