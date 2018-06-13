class Wine < ApplicationRecord

	#RELATIONSHIPS
	has_many :pairings, dependent: :destroy
	#a wine has many cookies that it can pair with
	has_many :cookies, through: :pairings, :source => :cookie #this solves a problem with the plurality of cookie
	belongs_to :user

	#VALIDATIONS
	validates :wine_name, presence: true
	validates :wine_name, uniqueness: true
	validates :grape_varietal, presence: true
	validates :origin, presence: true
	validates :description, presence: true
	validates :description, length: {maximum: 50, too_long: "%{count} characters is the maximum allowed" }
	validates :description, length: {minimum: 2, too_short: "%{count} characters is the minimum allowed" }

	#INSTANCE METHODS
	def paired_cookies
		self.cookies
	end

end
