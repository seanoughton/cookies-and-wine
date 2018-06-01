class User < ApplicationRecord

	has_secure_password

	#RELATIONSHIPS
	has_many :pairings
	has_many :comments
end
