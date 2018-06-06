module CommentsHelper

  def comment_pairing_id_field(comment)
    if comment.pairing.nil?
    else
      hidden_field_tag "comment[pairing_id]", comment.pairing_id
    end
  end



end
