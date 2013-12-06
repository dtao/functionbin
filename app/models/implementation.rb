class Implementation < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :function, :counter_cache => true
  has_many :upvotes
  has_many :comments, :as => :parent

  validates_presence_of :user_id
  validates_presence_of :function_id
  validates_presence_of :source, :message => 'An implementation without any code? Nice try.'

  strip_attributes

  def has_upvotes?
    self.score > 0
  end
end
