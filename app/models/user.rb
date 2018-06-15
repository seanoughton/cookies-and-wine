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


	#VALIDATION TO SEE IF THE USER ALREADY EXISTS IN THE DATABASE

	def user_already_exists
		user = User.find_by(user_name: self.user_name, email: self.email)
		if user
			errors.add(:user, "Already Exists. Try Logging In.")
		end
	end

	#AUTHORIZATIONS (STUFF THE ADMIN CAN DO)
	#EDIT/DELETE A User, Pairing, Wine, Cookie, Comment

	def user_permission(instance,current_user) #either admin or user created item

		if instance.class == User
			if self.admin || instance == current_user
				true
			else
				false
			end
		else
			if self.admin || instance.user == current_user
				true
			else
				false
			end		
		end


	end


=begin
	def user_permission
		if Thread.current[:current_user] == self.user
			true
		else
			errors.add(:pairing, "You don't have permission")
		end
	end
=end
	#WHAT DOES THE USER HAVE PERMISSION TO DO ON THIS THING
	def permission(thing)
		if self.admin || self == thing.user
			true
		else
			false
		end
	end


	def permission_to_edit?(current_user)
		current_user.admin? || self == current_user
	end

	def is_admin?
		self.admin
	end

	#ACTIVE RECORD SCOPE METHODS (MODEL CLASS METHODS)
	def self.most_pairings
		order( "pairings_count desc" ).first
	end

	def self.return_user(params)
		if params == "most_pairings"
			@user = User.most_pairings
		else
			@user = User.find(params)
		end
	end



end
