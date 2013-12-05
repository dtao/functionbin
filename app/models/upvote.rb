class Upvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :implementation, :counter_cache => :score

  validates_presence_of :user_id
  validates_presence_of :implementation_id
  validate              :prevent_cheating

  after_create :update_user_score

  def prevent_cheating
    if self.user_id == self.implementation.user_id
      self.errors.add(:user_id, "You can't vote for your own implementation.")
    end
    if self.user.upvoted?(self.implementation)
      self.errors.add(:implementation_id, "You can't vote for the same implementation twice.")
    end
  end

  def update_user_score
    User.increment_counter(:score, self.implementation.user_id)
  end
end
