class User < ApplicationRecord

	#RELATIONSHIPS
	has_many :pairings
	has_many :comments
	has_many :ratings
	has_many :cookies, foreign_key: "user_id", class_name: "Cookie"
	#THIS PREVENTS SOME WEIRDNESS WITH THE WAY THAT RUBY DEALS WITH THE SINGLE OF COOKIES. PREVENTS RUBY FROM LOOKING FOR A CLASS NAMED "COOKY"
	has_many :wines

	#VALIDATIONS
	has_secure_password #USES BCRYPT TO MAKE SURE THAT THE PASSWORD IS ENCRYPTED AND SALTED

	validates :user_name, presence: true
	validates :user_name, uniqueness: true
	#INTENTIONALLY LEFT OUT VALIDATING PRESENCE OF ZIPCODE SO THAT FACEBOOK USER COULD LOG IN WITHOUT HAVING TO INPUT THAT INFORMATION
	#validates :zipcode, numericality: { only_integer: true }
	validates :email, presence: true, 'valid_email_2/email': true
	validates :email, uniqueness: true

	#ACTIVE RECORD SCOPE METHODS (MODEL CLASS METHODS)
	#RETURNS THE USER WITH THE MOST PAIRINGS BASED ON THE PAIRINGS COUNT
	def self.most_pairings
		order( "pairings_count desc" ).first
	end


	#AUTHORIZATIONS

		#A USER CAN EDIT/DELETE THEIR OWN USER INFO
		#A USER CAN EDIT/DELETE THE THINGS THEY CREATED (COOKIES,WINES,PAIRINGS, COMMENTS)
		#AN ADMIN CAN EDIT/DELETE ANYTHING (COOKIE,WINE,PAIRING,COMMENT,USER)

		#THE INSTANCE IS THE THING THE USER WANTS TO CHANGE, WHICH COULD BE A COOKIE,WINE,COMMENT,PAIRING OR A USER
	def user_permission(instance,current_user)
		case instance
		when User #IF THAT THING IS A USER, ONLY A USER OR AN ADMIN CAN CHANGE
			true if self.admin || instance == current_user
		else
			#IF THAT THING IS SOMETHING BESIDES A USER, ONLY AN ADMIN OR THE USER THAT THE THING BELONGS TO CAN CHANGE IT
			true if self.admin || instance.user == current_user
		end
	end

	#DETERMINES IF THE USER'S EDIT PAGE WILL SHOW A PASSWORD OR NOT
	#USERS WHO SIGNUP/LOGIN WITH FACEBOOK DO NOT NEED A PASSWORD
	#WHEN THE ADMIN EDITS A USER, THE ADMIN DOES NOT HAVE ACCESS TO EDIT THE USER'S PASSWORD
	def show_password(current_user)
		if (current_user.admin && !self.admin) || self.uid
			return false
		else
			return true
		end
	end

end
