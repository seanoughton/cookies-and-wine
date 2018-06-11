module PairingsHelper

  #RETURNS A STRING WITH THE PAIRING'S USER RATING
  def show_rating(pairing)
    "Rating: #{pairing.user_rating}"
  end

  #RETURNS A STRING WITH THE PAIRING'S COMMENT COUNT
  def show_comment_count(pairing)
    "Comments: #{pairing.comments_count}"
  end

  #RETURNS THE HIGHEST RATED PAIRING
  def highest_rated_pairing
    Pairing.highest_rated
  end

  #RETURNS THE MOST COMMENTED PAIRING
  def most_commented_pairing
    Pairing.most_commented
  end

  #RETURNS THE NEWEST PAIRING
  def newest_pairing
    Pairing.newest
  end

  #RETURNS THE OLDEST PAIRING
  def oldest_pairing
    Pairing.oldest
  end

  #RETURNS USER WITH THE MOST PAIRINGS
  def user_with_most_pairings
    User.user_with_most_pairings
  end

  #RETURNS A RANDOM PAIRING
  def random_pairing
    Pairing.random_pairing
  end

  

end
