module FunctionBin
  class Upvote
    include DataMapper::Resource

    property :id,                Serial
    property :user_id,           Integer, :required => true, :index => true
    property :implementation_id, Integer, :required => true, :index => true
    property :created_at,        DateTime

    belongs_to :user
    belongs_to :implementation
  end
end
