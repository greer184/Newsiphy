module EntriesHelper

  def already_rated?(entry, user)
    id = entry.id
    user.ratings.each do |rating|
      if rating.entry_id == id then return true end
    end
    return false
  end

  def my_rating(entry, user)
    id = entry.id
    user.ratings.each do |rating|
      if rating.entry_id == id then return rating end    
    end
    return nil
  end

end
