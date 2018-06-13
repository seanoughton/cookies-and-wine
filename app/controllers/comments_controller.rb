class CommentsController < ApplicationController
  before_action :require_logged_in
  before_action :current_user

  def index
    @comments = Comment.find_each
    check_for_user(params)
    check_for_pairing(params)
  end

  def new #CREATES A COMMENT FOR A SPECIFIC PAIRING
    if !params[:pairing_id] || !Pairing.pairing_exists?(params[:pairing_id])
      redirect_to pairings_path, alert: "Pairing not found."
    else
      create_empty_comment(params[:pairing_id])
      find_pairing(params[:pairing_id],@comment)
    end

  end

  def create #CREATES A COMMENT FOR A SPECIFIC PAIRING
    @comment = Comment.new(comment_params)
    find_pairing((params[:comment][:pairing_id]),@comment)
    if @comment.valid?
      @comment.save
      redirect_to pairing_path(@pairing)
    else
      render :new
    end

  end

  def show #SHOWS A COMMENT FOR A SPECIFIC PAIRING
    find_comment(params[:id])
    find_pairing(params[:pairing_id],@comment)
  end

  def edit #EDITS A COMMENT FOR A SPECIFIC PAIRING
    find_comment(params[:id])
    find_pairing(params[:pairing_id],@comment)
  end

  def update #UPDATES A COMMENT FOR A SPECIFIC PAIRING

    find_comment(params[:id])
    find_pairing(params[:comment][:pairing_id],@comment)
    @comment.update(comment_params)
    redirect_to @pairing if @comment.valid?
    render :edit if !@comment.valid?

  end

  def destroy
    find_comment(params[:id])
    find_pairing(@comment.pairing.id,@comment)
    @comment.destroy
    redirect_to @pairing
  end

  #helpers

  #FINDS A PAIRING WITH A PAIRING ID
  #IF PAIRING ID DOES NOT EXIST IN THE PARAMS
  #ASSINGS PAIRING BASED ON THE COMMENT'S PARENT PAIRING
  def find_pairing(pairing_id,comment)
    if Pairing.exists?(pairing_id)
      @pairing = Pairing.find(pairing_id)
    else
      @pairing = comment.pairing
    end
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
