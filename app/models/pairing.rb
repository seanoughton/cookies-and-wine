class Pairing < ApplicationRecord


	#RELATIONSHIPS
	belongs_to :wine
	belongs_to :cookie
	belongs_to :user
	has_many :comments

	#ACTIVE RECOR SCOPE METHODS (MODEL CLASS METHODS)
	def self.highest_rated
		where("rating > '4'")
	end

	def self.lowest_rated
		where("rating < '2'")
	end

	def self.most_commented
	end

	def self.newest
		order(created_at: :desc).limit(1)
	end

	def self.oldest
		order(created_at: :asc).limit(1)
	end

	#PAIRINGS FOR A SPECIFIC COOKIE - returns all wines paired with a specific cookie
	def self.wines_with_this_cookie

	end

	#PAIRINGS FOR A SPECIFIC WINE


end
