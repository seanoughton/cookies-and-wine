class CommentsController < ApplicationController


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
  end

  def comment_params
    params.require(:comment).permit(:body, :pairing_id)
  end
end
