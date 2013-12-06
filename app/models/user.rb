class User < ActiveRecord::Base
  has_many :functions
  has_many :implementations
  has_many :upvotes
  has_many :comments

  validates_presence_of   :name
  validates_uniqueness_of :name,  :message => 'Every user name must be unique.'
  validates_presence_of   :email
  validates_uniqueness_of :email, :message => 'You have already signed up using that e-mail address.'

  def upvoted?(implementation)
    !!Upvote.find_by(:user => self, :implementation => implementation)
  end

  def upvote!(implementation)
    self.upvotes.create!(:implementation => implementation)
  end
end
