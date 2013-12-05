class User < ActiveRecord::Base
  has_many :functions
  has_many :implementations
  has_many :upvotes

  validates_presence_of   :name
  validates_presence_of   :email
  validates_uniqueness_of :email

  def upvoted?(implementation)
    !!Upvote.find_by(:user => self, :implementation => implementation)
  end

  def upvote!(implementation)
    self.upvotes.create!(:implementation => implementation)
  end
end
