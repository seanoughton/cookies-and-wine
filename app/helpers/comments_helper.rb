module CommentsHelper

  def comment_pairing_id_field(comment)
    if comment.pairing.nil?
      #select_tag "comment[pairing_id]", options_from_collection_for_select(Comment.all, :id, :name)
    else
      hidden_field_tag "comment[pairing_id]", comment.pairing_id
    end
  end


end
