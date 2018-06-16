class Cookie < ApplicationRecord

	#RELATIONSHIPS
	has_many :pairings, dependent: :destroy
	#a cookie has many wines that it can pair with
	has_many :wines, through: :pairings
	belongs_to :user

	#VALIDATIONS
	validates :cookie_name, presence: true
	validates :cookie_name, uniqueness: true ,on: :create
	validates :description, presence: true
	validates :description, length: {maximum: 50, too_long: "%{count} characters is the maximum allowed" }
	validates :description, length: {minimum: 2, too_short: "%{count} characters is the minimum allowed" }
	validates :link, url: true #uses gem to validate that the url is in proper format
	validates :link, uniqueness: true ,on: :create

end
