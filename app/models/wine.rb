class Wine < ApplicationRecord

	#VALIDATIONS
	validates :wine_name, presence: true
	validates :grape_varietal, presence: true
	validates :origin, presence: true
	validates :description, presence: true

	#RELATIONSHIPS
	has_many :pairings
	#a wine has many cookies that it can pair with
	has_many :cookies, through: :pairings, :source => :cookie #this solves a problem with the plurality of cookie

	def paired_cookies
		self.cookies
	end

end
