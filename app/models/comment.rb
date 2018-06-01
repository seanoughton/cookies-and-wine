class Comment < ApplicationRecord

	#RELATIONSHIPS
	belongs_to :user
	belongs_to :pairing

end
