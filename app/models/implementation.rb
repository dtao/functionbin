module FunctionBin
  class Implementation
    include DataMapper::Resource

    property :id,          Serial
    property :user_id,     Integer, :required => true, :index => true
    property :function_id, Integer, :required => true, :index => true
    property :source,      Text
    property :created_at,  DateTime
    property :updated_at,  DateTime

    belongs_to :user
    belongs_to :function
  end
end
