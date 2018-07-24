class Comment < ApplicationRecord

	#RELATIONSHIPS
	belongs_to :user
	belongs_to :pairing, :counter_cache => true #counts the number of comments created for a pairing. Pairings table has a comments_count column where this data is stored.

	#VALIDATIONS
	validates :body, presence: {message: "Comment Can't Be Empty"}
	validates :body, length: {maximum: 50, too_long: "%{count} characters is the maximum allowed" }
	validates :body, length: {minimum: 2, too_short: "%{count} characters is the minimum allowed" }

	#ACTIVE RECORD METHODS

	#RETRIEVES ALL OF THE COMMENTS FOR A PAIRING OR A USER OR JUST ALL COMMENTS
	def self.get_comments(params)

    if params[:pairing_id] && Pairing.exists?(params[:pairing_id])
			comments = Comment.where("pairing_id = ?", params[:pairing_id])
      #comments = Pairing.find(params[:pairing_id]).comments
    elsif params[:user_id] && User.exists?(params[:user_id])
			comments = Comment.where("user_id = ?", params[:user_id])
			#comments = User.find(params[:user_id]).comments
    else
      comments = Comment.find_each
    end
		comments

  end

end
