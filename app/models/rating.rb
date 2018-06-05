class Rating < ApplicationRecord

  #RELATIONSHIPS
  belongs_to :pairing
  belongs_to :user

  #VALIDATIONS
  validates :rating_value, presence: {message: "Must Have a User Rating"}


end
