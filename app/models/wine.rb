class Wine < ApplicationRecord

	#RELATIONSHIPS
	has_many :pairings, dependent: :destroy#THIS DESTROYS ALL OF THE DIRECT DEPENDENTS BASED ON THE has_many RELATIONSHIP

	#a wine has many cookies that it can pair with
	has_many :cookies, through: :pairings, :source => :cookie #this solves a problem with the way ruby pluralizes cookie
	belongs_to :user

	#VALIDATIONS
	validates :wine_name, presence: true
	validates :wine_name, uniqueness: true
	validates :grape_varietal, presence: true
	validates :origin, presence: true
	validates :description, presence: true
	validates :description, length: {maximum: 50, too_long: "%{count} characters is the maximum allowed" }
	validates :description, length: {minimum: 2, too_short: "%{count} characters is the minimum allowed" }

	# =>ACTIVE RECORD METHODS

	#RETURNS COLLECTION OF WINES: EITHER ALL WINES OR JUST A USER'S WINES
	def self.get_wines(params)
		if params[:user_id] && User.exists?(params[:user_id])
			user = User.find(params[:user_id])
			wines = user.wines
		else
			wines = Wine.find_each
		end
		wines
	end


end
