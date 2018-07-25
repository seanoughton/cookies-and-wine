class PairingSerializer < ActiveModel::Serializer
  attributes :id, :user_rating, :wine_id, :cookie_id, :user_id, :comments_count
  belongs_to :user
  belongs_to :wine
  belongs_to :cookie
end
