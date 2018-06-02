class Cookie < ApplicationRecord

	#RELATIONSHIPS
	has_many :pairings
	#a cookie has many wines that it can pair with
	has_many :wines, through: :pairings

	#PAIRINGS FOR A SPECIFIC COOKIE - returns all wines paired with a specific cookie
	def paired_wines #instance method
		self.wines
	end

end
