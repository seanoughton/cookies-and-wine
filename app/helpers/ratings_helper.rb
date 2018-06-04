module RatingsHelper

  def rating_pairing_id_field(rating)
    if rating.pairing.nil?
      select_tag "rating[pairing_id]", options_from_collection_for_select(Pairing.all, :id, :name)
    else
      hidden_field_tag "rating[pairing_id]", rating.pairing_id
    end
  end

end
