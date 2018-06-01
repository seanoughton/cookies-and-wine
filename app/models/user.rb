class User < ApplicationRecord

	#RELATIONSHIPS
	has_many :pairings
	has_many :comments
end
