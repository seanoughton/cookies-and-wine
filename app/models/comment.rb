class Comment < ApplicationRecord

	#RELATIONSHIPS
	belongs_to :user
	belongs_to :pairing

	#VALIDATIONS

	validates :body, presence: {message: "Comment Can't Be Empty"}
	validates :body, length: {maximum: 25, too_long: "%{count} characters is the maximum allowed" }
	validates :body, length: {minimum: 2, too_short: "%{count} characters is the minimum allowed" }



end
