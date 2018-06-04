class Rating < ApplicationRecord
  belongs_to :pairing
  belongs_to :user
end
