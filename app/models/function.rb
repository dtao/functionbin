class Function < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :implementations

  validates_presence_of   :user_id
  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_presence_of   :example
end
