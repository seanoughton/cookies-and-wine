class Pairing < ApplicationRecord

	#RELATIONSHIPS
	belongs_to :wine
	belongs_to :cookie
	belongs_to :user, :counter_cache => true #counts the number of pairings for a specific user
	has_many :comments, dependent: :destroy

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

	def self.pairing_exists?(pairing_id)
		self.exists?(pairing_id)
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
		#where('rating < ?', '2')
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

	def self.oldest
		order(created_at: :asc).first
	end

	def self.newest_list
		order(created_at: :desc).to_a
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


	def self.sort_order(sort_input)
		#take the sort input and a cookie id or a wine id and call the appropriate function
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


	def self.sort_the_pairings(params)
		#THIS SORTS THE PAIRINGS BASED ON THE SORT ORDER. FOR INSTANCE "NEWEST"
		@sorted_pairings = Pairing.sort_order(params[:sort])

		#THIS SCOPES THE OVERALL SORTED PAIRINGS BASED ON THE PARENT(COOKIE,WINE,USER). FOR INSTANCE, ONLY SHOW THE SORTED PAIRINGS THAT BELONG TO A SPECIFIC COOKIE
		if params[:cookie]
			@cookie = Cookie.find(params[:cookie])
			@pairings = @sorted_pairings.select do |pairing|
				pairing.cookie == @cookie
			end
		elsif params[:wine]
			@wine = Wine.find(params[:wine])
			@pairings = @sorted_pairings.select do |pairing|
				pairing.wine == @wine
			end
		elsif params[:user]
			@user = User.find(params[:user])
			@pairings = @sorted_pairings.select do |pairing|
				pairing.user == @user
			end
		else
			@pairings = @sorted_pairings
		end
		@pairings
	end

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

	def pairings_for_specific_cookie(cookie_id)
		byebug
		cookie = Cookie.find(cookie_id)
		self.collect do |pairing|
			pairing.cookie
		end
	end



	def update_rating #updates the user_rating
		ratings_array = Rating.all.select do |rating|
			rating.pairing == self
		end
		ratings_values = ratings_array.collect do |rating|
			rating.rating_value
		end
		self.user_rating = ratings_values.sum/ratings_values.count
		self.save(validate: false)
	end

	def delete_pairings_comments_ratings
		self.comments.each do |comment|
      comment.destroy
    end
    self.ratings.each do |rating|
      rating.destroy
    end
	end

end
