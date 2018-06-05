class Rating < ApplicationRecord


  #VALIDATIONS
  validates :rating_value, presence: {message: "Must Have a User Rating"}

  #RELATIONSHIPS
  belongs_to :pairing
  belongs_to :user
end
