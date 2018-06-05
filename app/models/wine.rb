class Wine < ApplicationRecord

	#VALIDATIONS
	validates :wine_name, presence: true
	validates :grape_varietal, presence: true
	validates :origin, presence: true
	validates :description, presence: true
	validates :description, length: {maximum: 25, too_long: "%{count} characters is the maximum allowed" }
validates :description, length: {minimum: 2, too_short: "%{count} characters is the minimum allowed" }


	#some kind of validation that prevents the description from just being numbers

	#RELATIONSHIPS
	has_many :pairings
	#a wine has many cookies that it can pair with
	has_many :cookies, through: :pairings, :source => :cookie #this solves a problem with the plurality of cookie

	def paired_cookies
		self.cookies
	end

end
