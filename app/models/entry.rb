class Entry < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  belongs_to :feed

  # Gives updated score for the entry
  def update_score
    sum = 0.0
    total = 0.0
    ratings.each do |rating|
      vp = User.find(rating.user_id).voting_power 
      sum = sum + rating.score * vp
      total = total + vp
    end
    average = sum / total
    variance = ratings.inject(0.0){ |sum, element| sum + 
                                 (element.score - average) ** 2 }
    penalty = Math.log10((variance / ratings.size) + 1) + 1.0;
    update_attribute(:score, average / penalty)
  end

  # Allocates rewards of voting power to each user prior to destruction
  def allocate_rewards(score)
    
    # Power allocated for this round
    total_users = User.all.count
    total_feeds = Feed.all.count
    power =  (total_users * 5) / (total_feeds * 1000)

    # Index values with related ids
    indexes = []
    total = 0.0
    val = 1
  
    # Sort each rating by update date
    ratings.order! 'updated_at ASC'
    ratings.each do |rating|
      user = User.find(rating.user_id)
      difference = rating.score - score 
      consistency = 0.99 * user.consistency + 0.01 * difference 
      index = Math.exp(-(val**1.5/total_users)) / 
              (difference**2 + (consistency - difference)**2 + 1)
      indexes.append([user.id, index])
      total = total + index
      val = val + 1
      user.consistency = consistency
    end

    # Normalize the voting power
    User.all.each do |user|
      user.voting_power = user.voting_power * (total_user * 5) / 
                          (total_users * 5 + power) 
    end

    # Add respective new voting power
    indexes.each do |element|
      user = User.find(element[0])
      user.voting_power = user.voting_power + (element[1] / total) * power
    end
   
  end

end
