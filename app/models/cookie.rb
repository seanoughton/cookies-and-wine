class Cookie < ApplicationRecord

	#VALIDATIONS
	validates :cookie_name, presence: true
	validates :cookie_name, uniqueness: true
	validates :description, presence: true
	validates :description, length: {maximum: 25, too_long: "%{count} characters is the maximum allowed" }
validates :description, length: {minimum: 2, too_short: "%{count} characters is the minimum allowed" }
	validates :link, url: true #uses gem
	validates :link, uniqueness: true


	#validation that the link is in a url format

	#RELATIONSHIPS
	has_many :pairings
	#a cookie has many wines that it can pair with
	has_many :wines, through: :pairings

	#PAIRINGS FOR A SPECIFIC COOKIE - returns all wines paired with a specific cookie
	def paired_wines #instance method
		self.wines
	end

end
