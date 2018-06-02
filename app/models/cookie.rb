class Cookie < ApplicationRecord

	#RELATIONSHIPS
	has_many :pairings
	#a cookie has many wines that it can pair with
	has_many :wines, through: :pairings

	#ACTIVE RECORD SCOPE METHODS (MODEL CLASS METHODS)

	#PAIRINGS FOR A SPECIFIC COOKIE - returns all wines paired with a specific cookie
	def self.wines_with_this_cookie

	end

end
