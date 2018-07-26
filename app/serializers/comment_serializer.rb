class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_id, :pairing_id
  belongs_to :user
end
