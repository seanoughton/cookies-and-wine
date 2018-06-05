class User < ApplicationRecord

	#VALIDATIONS
	has_secure_password
	validates :user_name, presence: true
	validates :user_name, uniqueness: true
	validates :password, presence: true
	validates :zipcode, presence: true
	validates :zipcode, numericality: { only_integer: true }
	validates :email, presence: true, 'valid_email_2/email': true
	validates :email, uniqueness: true
	#validates :email, presence: true
	validates :password, presence: true

	validate :user_already_exists

	def user_already_exists
		user = User.find_by(user_name: self.user_name, email: self.email)
		if user
			errors.add(:user, "Already Exists. Try Logging In.")
		end
	end

	#RELATIONSHIPS
	has_many :pairings
	has_many :comments
	has_many :ratings
end
