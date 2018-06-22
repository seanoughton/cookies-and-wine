class Pairing < ApplicationRecord

	#RELATIONSHIPS
	belongs_to :wine
	belongs_to :cookie
	belongs_to :user, :counter_cache => true #counts the number of pairings for a specific user. Users table has a pairings_count column where this data is stored.
	has_many :comments, dependent: :destroy #THIS DESTROYS ALL OF THE DIRECT DEPENDENTS BASED ON THE has_many RELATIONSHIP
	has_many :ratings, dependent: :destroy #THIS DESTROYS ALL OF THE DIRECT DEPENDENTS BASED ON THE has_many RELATIONSHIP

	#VALIDATIONS
	validates :wine_id, presence: {message: "Must Have a Wine"}
	validates :cookie_id, presence: {message: "Must Have a Cookie"}
	validate :pairing_already_exists, on: :create

	#CUSTOM VALIDATIONS

	#CHECKS TO SEE IF THE PAIRING ALREADY EXISTS
	def pairing_already_exists
		pairing = Pairing.find_by(wine_id: self.wine_id, cookie_id: self.cookie_id)
		if pairing
			errors.add(:pairing, "Already Exists. Try Creating a Different Pairing")
		end
	end

	#ACTIVE RECORD SCOPE METHODS (MODEL CLASS METHODS)

	## RETRIEVES ALL PAIRINGS FOR EITHER A WINE, A COOKIE, A USER OR JUST ALL THE PAIRINGS
	def self.get_pairings(params)
		if params[:wine_id] && Wine.exists?(params[:wine_id])
			pairings = Wine.find(params[:wine_id]).pairings
		elsif params[:cooky_id] && Cookie.exists?(params[:cooky_id])
			pairings = Cookie.find(params[:cooky_id]).pairings
		elsif params[:user_id] && User.exists?(params[:user_id])
			pairings = User.find(params[:user_id]).pairings
		else
			pairings = Pairing.find_each
		end
		pairings
	end



	#SORTING METHODS RETURNING A COLLECTION
	def self.highest_to_lowest
		order(user_rating: :desc).to_a
	end

	def self.lowest_to_highest
		order(user_rating: :asc).to_a
	end

	def self.most_commented_list
		order(comments_count: :desc).to_a
	end

	def self.newest_list
		order(created_at: :desc).to_a
	end

	def self.oldest_list
		order(created_at: :asc).to_a
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

	#SORTING METHODS RETURNING A SINGLE INSTANCE
	def self.highest_rated
		order(user_rating: :desc).limit(1).first
	end

	def self.lowest_rated
		order(user_rating: :asc).limit(1).first
	end

	def self.most_commented
		order(comments_count: :desc).first
	end

	def self.newest
		order(created_at: :desc).first
	end

	def self.oldest
		order(created_at: :asc).first
	end

	def self.random_pairing
		random_number = 0
		#keeps looking for a random number until it finds one that is included in the Pairing Id's
		while !self.ids.include?(random_number)
			random_number = rand(1...self.last.id)
		end
		self.find(random_number)
	end

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



#INSTANCE METHODS

#UPDATES THE USER RATING VALUE OF THE PAIRING
	def update_rating
		self.user_rating = self.ratings.sum("rating_value")/self.ratings.count
		self.save(validate: false) #THIS IS TO PREVENT ALL OF THE USER VALIDATIONS FROM RUNNING
	end

end
