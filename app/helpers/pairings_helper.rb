module PairingsHelper

  def show_rating(pairing)
    "Rating: #{pairing.user_rating}"
  end

  def show_comment_count(pairing)
    "Comments: #{pairing.comments_count}"
  end

  def highest_rated_pairing
    @highest_rated_pairing = Pairing.highest_rated
  end

  def most_commented_pairing
    @most_commented_pairing = Pairing.most_commented
  end

  def newest_pairing
    @newest_pairing = Pairing.newest
  end

  def oldest_pairing
    @oldest_pairing = Pairing.oldest
  end

  def user_with_most_pairings
    @user = User.user_with_most_pairings
  end

  def random_pairing
    @random_pairing = Pairing.find(rand(1...Pairing.last.id))
  end

end
