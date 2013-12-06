class Function < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :implementations
  has_many :comments, :as => :parent

  validates_presence_of   :user_id
  validates_presence_of   :name,    :message => 'Every function needs to have a name.'
  validates_uniqueness_of :name,    :message => 'A function already exists with that name.'
  validates_presence_of   :example, :message => 'Provide some example code to show how the function works.'
end
