class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :email, :zipcode, :uid, :image, :pairings_count
  has_many :pairings
  has_many :wines
  has_many :comments
end
