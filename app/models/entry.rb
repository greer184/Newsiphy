class Entry < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  belongs_to :feed

  # Gives updated score for the entry
  def update_score
    score = ratings.inject(0.0){ |sum, element| sum + element.score }
    average = score / ratings.size;
    score = ratings.inject(0.0){ |sum, element| sum + 
                                 (element.score - average) ** 2 }
    penalty = Math.log10((score / ratings.size) + 1) + 1.0;
    update_attribute(:score, average / penalty)
  end

end
