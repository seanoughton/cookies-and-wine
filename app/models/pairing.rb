class Pairing < ApplicationRecord


	#RELATIONSHIPS
	belongs_to :wine
	belongs_to :cookie
	belongs_to :user
	has_many :comments
	has_many :ratings

	#ACTIVE RECORD SCOPE METHODS (MODEL CLASS METHODS)
	def self.highest_rated
		#where("rating > 3")
		order(user_rating: :desc).limit(1).first
	end

	def self.lowest_rated
		where("rating < '2'")
	end

	def self.most_commented
		order(comment_count: :desc).first
	end

	def self.newest
		order(created_at: :desc).first
	end

	def self.oldest
		order(created_at: :asc).first
	end

#INSTANCE METHODS
	def updated_rating #averages the rating and updates the database
		#test for edge cases where the pairing does not have a rating
		if self.ratings.empty?
			rating = 0
		else
			rating_values = self.ratings.collect do |rating|
				rating.rating_value
			end
			rating = rating_values.sum/rating_values.count
			self.user_rating = rating #assigns the new rating
		end
		self.save
	end

	def updated_comment_count
		self.comment_count += 1
		self.save
	end



	#PAIRINGS FOR A SPECIFIC WINE


end
