module CommentsHelper

  def comment_pairing_id_field(comment)
    if comment.pairing.nil?
    else
      hidden_field_tag "comment[pairing_id]", comment.pairing_id
    end
  end


#COME BACK TO THIS
  def all_comments(comments)
    comments.collect do |comment|
      "<li>#{link_to comment.body, pairing_url(comment.pairing)}</li><"
    end.join

  end


end
