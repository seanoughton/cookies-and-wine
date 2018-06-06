module PairingsHelper

  def show_pairing(pairing)
    "#{pairing.wine.wine_name} is paired with #{pairing.cookie.cookie_name}."
  end

  def show_rating(pairing)
    "Rating: #{pairing.user_rating}"
  end

  def show_comment_count(pairing)
    "Comments: #{pairing.comment_count}"
  end


end
