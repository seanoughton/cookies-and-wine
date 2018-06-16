class Pairing < ApplicationRecord

	#RELATIONSHIPS
	belongs_to :wine
	belongs_to :cookie
	belongs_to :user, :counter_cache => true #counts the number of pairings for a specific user
	has_many :comments, dependent: :destroy
	has_many :ratings, dependent: :destroy

	#VALIDATIONS
	validates :wine_id, presence: {message: "Must Have a Wine"}
	validates :cookie_id, presence: {message: "Must Have a Cookie"}
	validate :pairing_already_exists, on: :create

	#CUSTOM VALIDATIONS
	def pairing_already_exists
		pairing = Pairing.find_by(wine_id: self.wine_id, cookie_id: self.cookie_id)
		if pairing
			errors.add(:pairing, "Already Exists. Try Creating a Different Pairing")
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
		order(user_rating: :desc).limit(1).first
	end

	def self.lowest_rated
		order(user_rating: :asc).limit(1).first
	end

	def self.most_commented_list
		order(comments_count: :desc).to_a
	end

	def self.most_commented
		order(comments_count: :desc).first
	end

	def self.newest
		order(created_at: :desc).first
	end

	def self.newest_list
		order(created_at: :desc).to_a
	end

	def self.oldest
		order(created_at: :asc).first
	end

	def self.oldest_list
		order(created_at: :asc).to_a
	end

	def self.random_pairing
		random_number = 0
		#keeps looking for a random number until it finds one that is included in the Pairing Id's
		while !self.ids.include?(random_number)
			random_number = rand(1...self.last.id)
		end
		self.find(random_number)
	end

#SORTING PAIRINGS METHODS

#RETURNS A SINGLE PAIRING SCOPED TO THE INPUT, FOR INSTANCE WILL RETURN THE SINGLE PAIRING WHICH IS THE HIGHEST RATED
	def self.return_pairing(params)
		if params == "highest_rated"
			@pairing = Pairing.highest_rated
		elsif params == "most_commented"
			@pairing = Pairing.most_commented
		elsif params == "oldest"
			@pairing = Pairing.oldest
		elsif params == "newest"
			@pairing = Pairing.newest
		elsif params == "random"
			@pairing = Pairing.random_pairing
		elsif Pairing.exists?(params)
			@pairing = Pairing.find(params)
		end
	end

#SORTS ALL OF THE PAIRINGS BASED ON THE SORT INPUT
	def self.sort_order(sort_input)
		case sort_input
		when "highest rated"
			highest_to_lowest
		when "lowest rated"
			lowest_to_highest
		when "most commented"
			most_commented_list
		when "newest"
			newest_list
		when "oldest"
			oldest_list
		else
			all
		end
	end

#INSTANCE METHODS

#UPDATES THE USER RATING VALUE OF THE PAIRING
	def update_rating
		self.user_rating = self.ratings.sum("rating_value")/self.ratings.count
		self.save(validate: false)
	end

end
