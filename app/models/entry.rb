class Entry < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  belongs_to :feed

  # Gives updated score for the entry
  def update_score
    score = ratings.inject(0.0){ |sum, element| sum + element.score }
    update_attribute(:score, score / ratings.size)
  end
end
