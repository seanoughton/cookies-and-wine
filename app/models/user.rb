class User < ApplicationRecord

	#RELATIONSHIPS
	has_many :pairings
	has_many :comments
	has_many :ratings
	has_many :cookies
	has_many :wines

	#VALIDATIONS
	has_secure_password #conflicts with omniauth

	validates :user_name, presence: true
	validates :user_name, uniqueness: true
	#validates :password, presence: true
	#validates :zipcode, presence: true
	#validates :zipcode, numericality: { only_integer: true }
	validates :email, presence: true, 'valid_email_2/email': true
	validates :email, uniqueness: true


	#validate :user_already_exists

	def user_already_exists
		user = User.find_by(user_name: self.user_name, email: self.email)
		if user
			errors.add(:user, "Already Exists. Try Logging In.")
		end
	end

	#AUTHORIZATIONS (STUFF ONLY THE ADMIN CAN DO)
	#EDIT/DELETE A User, Pairing, Wine, Cookie, Comment

	#A USER CAN EDIT THEIR OWN USER PROFILE
	#A USER CAN EDIT/DELETE THEIR OWN PAIRINGS?

	def is_admin?
		self.admin
	end

	#ACTIVE RECORD SCOPE METHODS (MODEL CLASS METHODS)
	def self.user_with_most_pairings
		order( "pairings_count desc" ).first
	end





end
