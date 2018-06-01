class Pairing < ApplicationRecord


	#RELATIONSHIPS
	belongs_to :wine
	belongs_to :cookie
	belongs_to :user
	belongs_to :comments
end
