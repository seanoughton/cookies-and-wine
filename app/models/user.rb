class User < ApplicationRecord

	#VALIDATIONS
	has_secure_password
	validates :user_name, presence: true
	validates :password, presence: true
	validates :zipcode, presence: true
	validates :zipcode, numericality: { only_integer: true }
	validates :password, presence: true

	#RELATIONSHIPS
	has_many :pairings
	has_many :comments
	has_many :ratings
end
