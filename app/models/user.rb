class User < ApplicationRecord

	has_secure_password
	validates :user_name, presence: true
	validates :password, presence: true

	#RELATIONSHIPS
	has_many :pairings
	has_many :comments
	has_many :ratings
end
