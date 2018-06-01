class Cookie < ApplicationRecord

	#RELATIONSHIPS
	has_many :pairings
	#a cookie has many wines that it can pair with
	has_many :wines, through: :pairings

end
