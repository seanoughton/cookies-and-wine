class Pairing < ApplicationRecord

	#RELATIONSHIPS
	belongs_to :wine
	belongs_to :cookie
	belongs_to :user
	has_many :comments
	has_many :ratings

	#VALIDATIONS
	validates :wine_id, presence: {message: "Must Have a Wine"}
	validates :cookie_id, presence: {message: "Must Have a Cookie"}
	validate :pairing_already_exists

	def pairing_already_exists
		pairing = Pairing.find_by(wine_id: self.wine_id, cookie_id: self.cookie_id)
		if pairing
			errors.add(:pairing, "This Pairing Already Exists. Try Creating a Different Pairing")
		end
	end



	#ACTIVE RECORD SCOPE METHODS (MODEL CLASS METHODS)

	def self.highest_to_lowest
		order(user_rating: :desc).to_a
	end

	def self.lowest_to_highest
		order(user_rating: :asc).to_a
	end

	def self.highest_rated
		#where("rating > 3")
		order(user_rating: :desc).limit(1).first
	end

	def self.lowest_rated
		where("rating < '2'")
	end

	def self.most_commented_list
		order(comment_count: :desc).to_a
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

	def self.newest_list
		order(created_at: :desc).to_a
	end

	def self.oldest_list
		order(created_at: :asc).to_a
	end

	def self.delete_associated_pairings_for_cookie(cookie_id)
		Pairing.where(cookie_id: cookie_id).find_each do |pairing|
		  pairing.destroy
		end
	end


		def self.delete_associated_pairings_for_wine(wine_id)
			Pairing.where(wine_id: wine_id).find_each do |pairing|
			  pairing.destroy
			end
		end

#INSTANCE METHODS
	def update_rating #averages the rating and updates the database
		if self.ratings.empty?
			self.user_rating = 1
		else
			rating_values = self.ratings.collect do |rating|
				rating.rating_value
			end
			rating = rating_values.sum/rating_values.count
			self.user_rating = rating #assigns the new rating
		end
		self.save(validate: false) #might need to change this
	end

	def updated_comment_count
		self.comment_count += 1
		self.save(validate: false)
	end






end
