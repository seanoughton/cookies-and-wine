class Wine < ApplicationRecord

	#RELATIONSHIPS
	has_many :pairings
	#a wine has many cookies that it can pair with
	has_many :cookies, through: :pairings, :source => :cookie #this solves a problem with the plurality of cookie

end
