class WineSerializer < ActiveModel::Serializer
  attributes :id, :wine_name, :grape_varietal, :origin, :description
  belongs_to :user
  has_many :pairings
end
