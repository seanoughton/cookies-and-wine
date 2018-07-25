class CookieSerializer < ActiveModel::Serializer
  attributes :id, :cookie_name, :description, :link, :user_id
  has_many :pairings
end
