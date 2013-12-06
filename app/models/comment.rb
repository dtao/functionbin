class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :counter_cache => true, :polymorphic => true

  validates_presence_of :parent_type
  validates_presence_of :parent_id
  validates_presence_of :content, :message => "What's the point of a blank comment?"

  strip_attributes
end
