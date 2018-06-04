class Pairing < ApplicationRecord


	#RELATIONSHIPS
	belongs_to :wine
	belongs_to :cookie
	belongs_to :user
	has_many :comments
	has_many :ratings

	#ACTIVE RECORD SCOPE METHODS (MODEL CLASS METHODS)
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


	def rating #returns the average of all of the ratings of an instance of a pairing
		rating_values = self.ratings.collect do |rating|
			rating.rating_value
		end
		rating_values.sum/rating_values.count
	end



	#PAIRINGS FOR A SPECIFIC WINE


end
