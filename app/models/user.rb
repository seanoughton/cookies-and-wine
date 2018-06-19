class User < ApplicationRecord

	#RELATIONSHIPS
	has_many :pairings
	has_many :comments
	has_many :ratings
	has_many :cookies, foreign_key: "user_id", class_name: "Cookie"
	has_many :wines

	#VALIDATIONS
	has_secure_password

	validates :user_name, presence: true
	validates :user_name, uniqueness: true
	#INTENTIONALLY LEFT OUT VALIDATING PRESENCE OF ZIPCODE SO THAT FACEBOOK USER COULD LOG IN WITHOUT HAVING TO INPUT THAT INFORMATION
	#validates :zipcode, numericality: { only_integer: true }
	validates :email, presence: true, 'valid_email_2/email': true
	validates :email, uniqueness: true

	#ACTIVE RECORD SCOPE METHODS (MODEL CLASS METHODS)
	def self.most_pairings
		order( "pairings_count desc" ).first
	end


	#AUTHORIZATIONS
	def user_permission(instance,current_user)
		case instance
		when User
			true if self.admin || instance == current_user
		else
			true if self.admin || instance.user == current_user
		end
	end

end
